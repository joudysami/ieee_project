import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/feature/auth/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login(String email, String password) async {
    try {
      final cleanEmail = email.trim();
      final cleanPassword = password.trim();

      await _firebaseAuth.signInWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );
      final userDod = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      return userDod.data()?['enrollment'] ?? 'Student';
    } catch (e) {
      //throw Exception(e.toString());
      rethrow;
    }
  }

  Future<void> register(
    String email,
    String password,
    String name,
    String phone,
    String institute,
    String enrollment,
  ) async {
    try {
      final cleanEmail = email.trim();
      final cleanPassword = password.trim();
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final userId = newUser.user!.uid;
      await _firestore.collection('users').doc(userId).set({
        'name': name.trim(),
        'email': cleanEmail,
        'phone': phone,
        'institute': institute,
        'enrollment': enrollment,
      });
    } catch (e) {
      // throw Exception(e.toString());
      rethrow;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      final cleanEmail = email.trim();
      final userQuery = await _firestore
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
  Future<String?> signInWithGoogle() async {
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
        final DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>?;
          return data?['enrollment'] ?? 'Student';
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeProfile({
    required String phone,
    required String institute,
    required String enrollment,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'phone': phone.trim(),
          'institute': institute,
          'enrollment': enrollment,
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
