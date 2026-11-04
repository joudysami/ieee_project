import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/feature/student/data/models/student_home_data.dart';
import 'package:ieee/feature/student/data/student_config.dart';
import 'package:ieee/feature/student/domain/repositories/student_repository.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository repository;

  StudentCubit({required this.repository}) : super(StudentInitial());

  Future<void> loadHome() async {
    final user = CacheHelp.getUser();
    final studentId = user?.uId ?? '';
    // Uses cached trackId when present; otherwise StudentConfig fallback.
    final trackId = StudentConfig.resolveTrackId();

    if (studentId.isEmpty) {
      emit(const StudentError('No authenticated student found. Please log in again.'));
      return;
    }

    emit(StudentLoading());
    try {
      final home = await repository.loadHomeData(
        studentId: studentId,
        studentName: user?.name ?? '',
        trackId: trackId,
      );
      emit(StudentHomeLoaded(home));
    } catch (e) {
      log('StudentCubit.loadHome: $e');
      emit(StudentError(e.toString()));
    }
  }
}
