part of 'student_cubit.dart';

abstract class StudentState {
  const StudentState();
}

class StudentInitial extends StudentState {
  const StudentInitial();
}

class StudentLoading extends StudentState {
  const StudentLoading();
}

class StudentHomeLoaded extends StudentState {
  final StudentHomeData home;
  const StudentHomeLoaded(this.home);
}

class StudentError extends StudentState {
  final String message;
  const StudentError(this.message);
}
