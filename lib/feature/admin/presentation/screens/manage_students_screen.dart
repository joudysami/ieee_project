import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/feature/admin/data/models/track_student.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/helpers/cache_help.dart';
import '../../../../core/widgets/main_sam_card.dart';
import '../../../../core/widgets/statistic_style.dart';
import '../../../../core/widgets/sub_sam_card.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../manager/admin_cubit.dart';

class ManageStudentsScreen extends StatefulWidget {
  const ManageStudentsScreen({super.key});

  @override
  State<ManageStudentsScreen> createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            final remoteDataSource = AdminRemoteDataSourceImpl();
            final repository = AdminRepositoryImpl(
              remoteDataSource: remoteDataSource,
            );
            return AdminCubit(repository: repository)
              ..loadStudentsByTrackId(CacheHelp.trackId ?? '');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.manageStudents,
                  style: TextStyle(
                    color: context.colors.primary,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppString.viewAndManageStudents,
                  style: TextStyle(
                    color: context.colors.sky.shade700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: BlocBuilder<AdminCubit, AdminState>(
                    builder: (context, state) {
                      if (state is AdminLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }

                      if (state is AdminError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      if (state is AdminStudentsLoaded) {
                        final List<TrackStudent> students = state.students;

                        if (students.isEmpty) {
                          return const Center(
                            child: Text('No students found for this track.'),
                          );
                        }

                        return ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            return MainSamCard(
                              head: student.userName,
                              onMenuTap: () {},
                              child: SubSamCard(
                                statistics: [
                                  StatisticItem(
                                    title: 'Score',
                                    content: statText(
                                      student.userScore.toDouble(),
                                      color: context.colors.sky.shade600,
                                    ),
                                  ),
                                  StatisticItem(
                                    title: 'Attendance',
                                    content: Text(
                                      '${student.attendHasDone}/${student.nofSessions}',
                                      style: TextStyle(
                                        color: context.colors.sky.shade600,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  StatisticItem(
                                    title: 'Assignments',
                                    content: Text(
                                      '${student.assignmentHaseDone}/${student.nofAssignments}',
                                      style: TextStyle(
                                        color: context.colors.sky.shade600,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
