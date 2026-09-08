import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/feature/auth/repo/auth_repo.dart';
import 'package:ieee/feature/auth/repo/auth_repo_imp.dart';

class AuthCubit extends Cubit<AppStates> {
  final AuthRepo _repo = AuthRepoImp();
  String? userRole;
  String? errorMessage;
  AuthCubit() : super(AppStates.initial);

  Future<void> login(String email, String password) async {
    emit(AppStates.loading);
    
    try {
      userRole = await _repo.login(email, password);
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
      await _repo.register(email, password, name, phone, institute, enrollment);
      userRole = enrollment;
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
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AppStates.googleLoading);
    try {
      final role = await _repo.signInWithGoogle();
      if (role != null) {
        userRole = role;
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
      await _repo.completeProfile(
        enrollment: enrollment,
        phone: phone,
        institute: institute,
      );
      userRole = enrollment;
      errorMessage = null;
      emit(AppStates.success);
    } catch (e) {
      errorMessage = e.toString();
      emit(AppStates.error);
    }
  }
}
