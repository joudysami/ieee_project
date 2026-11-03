import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/feature/admin/presentation/manager/admin_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:ieee/core/widgets/statistic_style.dart';
import 'package:ieee/core/widgets/sub_sam_card.dart';
import '../../../../core/widgets/main_sam_card.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../data/repositories/admin_repository_impl.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final remoteDataSource = AdminRemoteDataSourceImpl();
          final repository = AdminRepositoryImpl(
            remoteDataSource: remoteDataSource,
          );
          return AdminCubit(repository: repository)
            ..loadAssignmentsByTrackId(CacheHelp.trackId ?? '');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_outlined),
              ),
              Text(
                AppString.assignment,
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppString.viewAndMangeAss,
                style: TextStyle(
                  color: context.colors.sky.shade700,
                  fontSize: 16,
                ),
              ),
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
                        child: Text(state.message, textAlign: TextAlign.center),
                      );
                    }

                    if (state is AdminAssignmentsLoaded) {
                      final List<AssignmentModel> assignments =
                          state.assignments;

                      if (assignments.isEmpty) {
                        return const Center(child: Text('No Assignments yet'));
                      }

                      return ListView.builder(
                        itemCount: assignments.length,
                        itemBuilder: (context, index) {
                          final assignment = assignments[index];

                          return MainSamCard(
                            head: '${assignment.title} ',
                            menuItems: [
                              CardMenuItem(
                                label: 'Edit',
                                icon: Icons.edit_outlined,
                                onTap: () {},
                              ),
                              CardMenuItem(
                                label: 'Delete',
                                icon: Icons.delete_outline,
                                color: Colors.red,
                                onTap: () {},
                              ),
                            ],
                            child: SubSamCard(
                              statistics: [
                                StatisticItem(
                                  title: 'Deadline ',
                                  content: statDate(
                                    assignment.deadline ?? '',
                                    color: context.colors.sky.shade900,
                                  ),
                                ),
                                StatisticItem(
                                  title: 'link',
                                  content: statIcon(
                                    icon: Icons.open_in_new,
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(assignment.assignmentUrl),
                                        mode: LaunchMode.inAppBrowserView,
                                      );
                                    },
                                  ),
                                ),
                                StatisticItem(
                                  title: 'date',
                                  content: statDate(
                                    assignment.deadline ?? '',
                                    color: context.colors.sky.shade500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
