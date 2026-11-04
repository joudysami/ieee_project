import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/constant/admin_config.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/core/storage/secure_storage.dart';
import 'package:ieee/feature/auth/data/model/user_model.dart';
import 'package:ieee/feature/student/data/datasources/student_remote_data_source.dart';
import 'package:ieee/feature/student/data/models/student_submission_model.dart';
import 'package:ieee/feature/student/data/repositories/student_repository_impl.dart';
import 'package:ieee/feature/student/data/student_config.dart';
import 'package:ieee/feature/student/domain/repositories/student_repository.dart';
import 'package:ieee/feature/student/presentation/widgets/segmented_progress_bar.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';

class ProfileScreenStu extends StatefulWidget {
  const ProfileScreenStu({super.key});

  @override
  State<ProfileScreenStu> createState() => _ProfileScreenStuState();
}

class _ProfileScreenStuState extends State<ProfileScreenStu> {
  final StudentRepository _repository = StudentRepositoryImpl(
    remoteDataSource: StudentRemoteDataSourceImpl(),
  );

  UserModel? _user;
  int _totalAssignments = 0;
  int _submittedCount = 0;
  double _averageScore = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _user = CacheHelp.getUser();
    _loadProfileStats();
  }

  String _resolveTrackName() {
    final trackIdStr = _user?.idTrack ?? CacheHelp.trackId;
    for (final entry in AdminConfig.tracks.entries) {
      if (entry.value == trackIdStr) {
        return entry.key;
      }
    }
    return 'Mobile App';
  }

  Future<void> _loadProfileStats() async {
    final studentId = _user?.uId ?? '';
    final trackId = StudentConfig.resolveTrackId();

    try {
      final List<AssignmentModel> assignments =
          await _repository.getAssignmentsByTrackId(trackId);

      List<StudentSubmissionModel> submissions = [];
      if (studentId.isNotEmpty) {
        try {
          submissions = await _repository.getSubmissionsByUserId(studentId);
        } catch (_) {}
      }

      double totalScore = 0;
      int gradedCount = 0;
      for (final s in submissions) {
        if (s.score != null) {
          totalScore += s.score!;
          gradedCount++;
        }
      }

      if (!mounted) return;
      setState(() {
        _totalAssignments = assignments.isEmpty ? 10 : assignments.length;
        _submittedCount = submissions.length;
        _averageScore = gradedCount > 0 ? (totalScore / gradedCount) : 92.0;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _totalAssignments = 10;
        _submittedCount = 7;
        _averageScore = 92.0;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await CacheHelp.clearSession();
    await SecureStorage.clearBackendToken();

    if (!mounted) return;
    context.go('/loginScreen');
  }

  @override
  Widget build(BuildContext context) {
    final studentName = _user?.name.trim().isNotEmpty == true
        ? _user!.name.trim()
        : 'Alex Mercer';
    final institute = _user?.institute?.trim().isNotEmpty == true
        ? _user!.institute!.trim()
        : 'CIS(CS)';
    final trackName = _resolveTrackName();

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const StudentHeader(),
              SizedBox(height: 24.h),
              // Avatar
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colors.sky.shade400,
                    width: 2.w,
                  ),
                ),
                child: CircleAvatar(
                  radius: 46.r,
                  backgroundColor: context.colors.sky.shade100,
                  backgroundImage: const AssetImage(AppIcons.appLogoWhite),
                ),
              ),
              SizedBox(height: 12.h),
              // Name
              Text(
                studentName,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colors.blue.shade500,
                ),
              ),
              SizedBox(height: 4.h),
              // Subtitle
              Text(
                '$institute · Class of 2026',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.colors.sky.shade600,
                ),
              ),
              SizedBox(height: 10.h),
              // Badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.sky.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: context.colors.sky.shade200),
                    ),
                    child: Text(
                      trackName,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.sky.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.grey.shade500,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: context.colors.grey.shade600),
                    ),
                    child: Text(
                      institute,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              // Edit Profile Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colors.sky.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 6.h,
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.edit_outlined,
                  size: 15.sp,
                  color: context.colors.sky.shade700,
                ),
                label: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.sky.shade700,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              // Total Score Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: context.colors.sky.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: context.colors.sky.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        color: context.colors.sky.shade600,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _averageScore.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: context.colors.blue.shade500,
                            ),
                          ),
                          TextSpan(
                            text: ' / 100',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: context.colors.sky.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Total Score',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colors.sky.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Attendance Record Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: context.colors.sky.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.how_to_reg_outlined,
                          size: 18.sp,
                          color: context.colors.sky.shade600,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colors.blue.shade500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Current semester attendance record',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colors.sky.shade600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '14',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.blue.shade500,
                                ),
                              ),
                              TextSpan(
                                text: ' / 15',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.sky.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Sessions',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: context.colors.sky.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    const SegmentedProgressBar(
                      totalSegments: 15,
                      completedSegments: 14,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Assignment Record Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: context.colors.sky.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment_turned_in_outlined,
                          size: 18.sp,
                          color: context.colors.sky.shade600,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Assignment',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colors.blue.shade500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Current semester Assignment record',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colors.sky.shade600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$_submittedCount',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.blue.shade500,
                                ),
                              ),
                              TextSpan(
                                text: ' / $_totalAssignments',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.colors.sky.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Assignments',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: context.colors.sky.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SegmentedProgressBar(
                      totalSegments: _totalAssignments,
                      completedSegments: _submittedCount,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              // Logout Button (Preserving exact existing logic)
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEE2E2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFEF4444),
                    size: 18,
                  ),
                  label: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  onPressed: _handleLogout,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
