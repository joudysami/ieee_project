import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/constant/score_color.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/widgets/custome_notification.dart';
import 'package:ieee/feature/student/data/datasources/student_remote_data_source.dart';
import 'package:ieee/feature/student/data/models/student_home_data.dart';
import 'package:ieee/feature/student/data/repositories/student_repository_impl.dart';
import 'package:ieee/feature/student/presentation/manager/student_cubit.dart';
import 'package:ieee/feature/student/presentation/widgets/circular_stat.dart';
import 'package:ieee/feature/student/presentation/widgets/recent_update_tile.dart';
import 'package:ieee/feature/student/presentation/widgets/upcoming_session_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';

class HomeScreenStu extends StatelessWidget {
  const HomeScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final repository = StudentRepositoryImpl(
          remoteDataSource: StudentRemoteDataSourceImpl(),
        );
        return StudentCubit(repository: repository)..loadHome();
      },
      child: const _StudentHomeBody(),
    );
  }
}

class _StudentHomeBody extends StatelessWidget {
  const _StudentHomeBody();

  Future<void> _openLink(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            if (state is StudentLoading || state is StudentInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (state is StudentError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: context.colors.error),
                      ),
                      SizedBox(height: 16.h),
                      TextButton(
                        onPressed: () => context.read<StudentCubit>().loadHome(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is StudentHomeLoaded) {
              return _HomeContent(
                home: state.home,
                onJoin: () {
                  final link = state.home.upcomingSession?.meetingLink ??
                      state.home.track?.meeting;
                  _openLink(link);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final StudentHomeData home;
  final VoidCallback onJoin;

  const _HomeContent({
    required this.home,
    required this.onJoin,
  });

  List<Widget> _recentUpdateTiles(BuildContext context) {
    final graded = home.submissions
        .where((s) => s.score != null)
        .take(3)
        .toList();

    if (graded.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            'No recent updates yet',
            style: TextStyle(
              fontSize: 13.sp,
              color: context.colors.sky.shade600,
            ),
          ),
        ),
      ];
    }

    return graded
        .map(
          (s) {
            final scoreColor = getScoreColor(s.score!);
            return RecentUpdateTile(
              title: 'Assignment Graded',
              subtitle:
                  'Score ${s.score!.toStringAsFixed(0)}/100 · #${s.assignmentId}',
              icon: Icons.assignment_turned_in_outlined,
              iconColor: scoreColor,
              iconBgColor: scoreColor.withValues(alpha: 0.12),
            );
          },
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = home.studentName.trim().isEmpty
        ? (CacheHelp.getUser()?.name ?? 'Student')
        : home.studentName.trim().split(' ').first;

    return RefreshIndicator(
      onRefresh: () => context.read<StudentCubit>().loadHome(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: context.colors.sky.shade100,
                  backgroundImage: const AssetImage(AppIcons.appLogoWhite),
                ),
                Expanded(
                  child: Text(
                    'IEEE Student Activity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colors.blue.shade500,
                    ),
                  ),
                ),
                const NotificationBell(count: 0),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Hello, $firstName',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: context.colors.blue.shade500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Ready to continue your learning journey?',
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colors.sky.shade600,
              ),
            ),
            SizedBox(height: 18.h),
            UpcomingSessionCard(
              session: home.upcomingSession,
              meetingFallback: home.track?.meeting,
              onJoin: onJoin,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Attendance % needs GetAttendanceByStudentId response schema.
                const CircularStat(
                  label: 'Attendance',
                  placeholder: '--',
                ),
                CircularStat(
                  label: 'Assignments',
                  percent: home.assignmentsPercent,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              'Recent Updates',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: context.colors.blue.shade500,
              ),
            ),
            SizedBox(height: 4.h),
            ..._recentUpdateTiles(context),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
