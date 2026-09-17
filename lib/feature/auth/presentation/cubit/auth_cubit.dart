import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/feature/auth/data/model/user_model.dart';
import 'package:ieee/feature/auth/repo/auth_repo.dart';
import 'package:ieee/feature/auth/repo/auth_repo_imp.dart';

class AuthCubit extends Cubit<AppStates> {
  final AuthRepo _repo = AuthRepoImp();
  UserModel? currentUser;
  String? errorMessage;

  AuthCubit() : super(AppStates.initial);

  Future<void> login(
    String email,
    String password, {
    bool isRemembered = false,
  }) async {
    emit(AppStates.loading);
    try {
      final UserModel user = await _repo.login(email, password);
      currentUser = user;
      await CacheHelp.saveUserSession(user: user, isRemembered: isRemembered);
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
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
    emit(AppStates.registerLoading);
    try {
      final UserModel user = await _repo.register(
        email,
        password,
        name,
        phone,
        institute,
        enrollment,
      );
      currentUser = user;

      await CacheHelp.saveUserSession(user: user, isRemembered: true);
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AppStates.loading);
    try {
      await _repo.forgetPassword(email);
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AppStates.error);
    }
  }

  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    emit(AppStates.loading);
    try {
      await _repo.confirmPasswordReset(code: code, newPassword: newPassword);
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }

  Future<void> signInWithGoogle({bool isRemembered = false}) async {
    emit(AppStates.googleLoading);
    try {
      final UserModel? user = await _repo.signInWithGoogle();
      if (user != null) {
        currentUser = user;

        await CacheHelp.saveUserSession(user: user, isRemembered: isRemembered);

        errorMessage = null;
        emit(AppStates.success);
      } else {
        errorMessage = null;
        emit(AppStates.neededCompleteProfile);
      }
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }

  Future<void> completeProfile({
    required String enrollment,
    required String phone,
    required String institute,
  }) async {
    emit(AppStates.loading);
    try {
      final UserModel user = await _repo.completeProfile(
        enrollment: enrollment,
        phone: phone,
        institute: institute,
      );

      currentUser = user;

      await CacheHelp.saveUserSession(user: user, isRemembered: true);
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }
}
