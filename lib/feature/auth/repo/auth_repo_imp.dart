import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/network/api_client.dart';
import 'package:ieee/core/storage/secure_storage.dart';
import 'package:ieee/feature/auth/data/model/user_model.dart';
import 'package:ieee/feature/auth/repo/auth_repo.dart';
import 'dart:developer';

import '../../../core/constant/api_endpoint.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final cleanEmail = email.trim();
      final cleanPassword = password.trim();

      await _firebaseAuth.signInWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final idToken = await _firebaseAuth.currentUser!.getIdToken();
      log("================ FIREBASE ID TOKEN ================");
      log(idToken ?? "NO TOKEN FOUND");
      log("==================================================");
      final userDoc = await _fireStore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      final data = userDoc.data() ?? {};
      data['uid'] = _firebaseAuth.currentUser!.uid;
      data['idToken'] = idToken;



      return UserModel.fromMap(data);
    } catch (e) {
      //throw Exception(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String phone,
    String institute,
    String enrollment,
    String? idTrack, {
    bool isRemembered = false,
  }) async {
    try {
      final cleanEmail = email.trim();
      final cleanPassword = password.trim();

      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final userId = newUser.user!.uid;
      final idToken = await newUser.user!.getIdToken(true);

      log("================ FIREBASE ID TOKEN ================");
      log(idToken ?? "NO TOKEN FOUND");
      log("==================================================");
      final userData = {
        'uid': userId,
        'name': name.trim(),
        'email': cleanEmail,
        'phone': phone,
        'institute': institute,
        'enrollment': enrollment,
        'idToken': idToken,
        if (idTrack != null) 'idTrack': idTrack,
      };

      await _fireStore.collection('users').doc(userId).set(userData);

      final response = await ApiClient.post(
        path: ApiEndpoint.registerWithToken,
        queryParameters: {'IdToken': idToken},
      );

      final backendToken = response.data['token'] as String;
      await SecureStorage.saveBackendToken(backendToken);
      return UserModel.fromMap(userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      final cleanEmail = email.trim();
      final userQuery = await _fireStore
          .collection('users')
          .where('email', isEqualTo: cleanEmail)
          .get();

      if (userQuery.docs.isEmpty) {
        throw Exception(AppString.emailNotRegisted);
      }
      await _firebaseAuth.sendPasswordResetEmail(
        email: cleanEmail,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://ieee-project-561ee.firebaseapp.com/resetPasswordScreen',
          handleCodeInApp: true,
          androidInstallApp: true,
          androidMinimumVersion: '12',
          androidPackageName: 'com.example.ieee',
        ),
      );
    } catch (e) {
      //throw Exception(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,

  }) async {
    try {
      final cleanPassword = newPassword.trim();
      final cleanCode = code.trim();
      await _firebaseAuth.confirmPasswordReset(
        code: cleanCode,
        newPassword: cleanPassword,
      );
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final String? idToken = googleUser.authentication.idToken;

      final authorization = await googleUser.authorizationClient
          .authorizeScopes(['email', 'profile']);
      final String accessToken = authorization.accessToken;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        final idToken = await user.getIdToken(true);

        final DocumentSnapshot userDoc = await _fireStore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          final data = userDoc.data() as Map<String, dynamic>;
          data['uid'] = user.uid;
          data['idToken'] = idToken;

          final response = await ApiClient.post(
            path: ApiEndpoint.registerWithToken,
            queryParameters: {'IdToken': idToken},
          );

          final backendToken = response.data['token'] as String;
          await SecureStorage.saveBackendToken(backendToken);

          return UserModel.fromMap(data);
        } else {
          return null;
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> completeProfile({
    required String phone,
    required String institute,
    required String enrollment,
    String? idTrack,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('User is not logged in');
      }
      final idToken = await user.getIdToken(true);

      final userData = {
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': phone.trim(),
        'institute': institute,
        'enrollment': enrollment,
        'idToken': idToken,
        'idTrack': ?idTrack,

      };

      await _fireStore.collection('users').doc(user.uid).set(userData);

      final response = await ApiClient.post(
        path: ApiEndpoint.registerWithToken,
        queryParameters: {'IdToken': idToken},
      );

      log('status : ${response.statusCode}');
      log('data : ${response.data}');

      return UserModel.fromMap(userData);
    } on DioException catch (e) {
      log('========== BACKEND ERROR ==========');
      log('STATUS: ${e.response?.statusCode}');
      log('DATA: ${e.response?.data}');
      log('URL: ${e.requestOptions.uri}');
      log('HEADERS: ${e.requestOptions.headers}');
      log('===================================');

      rethrow;
    }
  }

  @override
  Future<String?> getValidIdToken() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    try {
      return await user.getIdToken(true); // force refresh
    } catch (e) {
      rethrow;
    }
  }
}
