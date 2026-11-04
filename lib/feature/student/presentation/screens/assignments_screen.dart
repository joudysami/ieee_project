import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/core/widgets/statistic_style.dart';
import 'package:ieee/feature/student/data/datasources/student_remote_data_source.dart';
import 'package:ieee/feature/student/data/models/student_submission_model.dart';
import 'package:ieee/feature/student/data/repositories/student_repository_impl.dart';
import 'package:ieee/feature/student/data/student_config.dart';
import 'package:ieee/feature/student/domain/repositories/student_repository.dart';
import 'package:ieee/feature/student/presentation/screens/ass_details_screen.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';

class AssignmentsScreenStu extends StatefulWidget {
  const AssignmentsScreenStu({super.key});

  @override
  State<AssignmentsScreenStu> createState() => _AssignmentsScreenStuState();
}

class _AssignmentsScreenStuState extends State<AssignmentsScreenStu> {
  final StudentRepository _repository = StudentRepositoryImpl(
    remoteDataSource: StudentRemoteDataSourceImpl(),
  );

  bool _isLoading = true;
  String? _errorMessage;
  List<AssignmentModel> _assignments = [];
  List<StudentSubmissionModel> _submissions = [];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Submitted', 'Reviewed'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final user = CacheHelp.getUser();
    final studentId = user?.uId ?? '';
    final trackId = StudentConfig.resolveTrackId();

    try {
      final results = await Future.wait([
        _repository.getAssignmentsByTrackId(trackId),
        if (studentId.isNotEmpty)
          _repository.getSubmissionsByUserId(studentId)
        else
          Future.value(<StudentSubmissionModel>[]),
      ]);

      if (!mounted) return;
      setState(() {
        _assignments = results[0] as List<AssignmentModel>;
        _submissions = results[1] as List<StudentSubmissionModel>;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  StudentSubmissionModel? _findSubmission(int assignmentId) {
    for (final s in _submissions) {
      if (s.assignmentId == assignmentId) return s;
    }
    return null;
  }

  String _getAssignmentStatus(StudentSubmissionModel? sub) {
    if (sub == null) return 'Pending';
    if (sub.score != null) return 'Reviewed';
    return 'Submitted';
  }

  List<AssignmentModel> get _filteredAssignments {
    if (_selectedFilter == 'All') return _assignments;

    return _assignments.where((a) {
      final sub = _findSubmission(a.assignmentId);
      final status = _getAssignmentStatus(sub);
      return status == _selectedFilter;
    }).toList();
  }

  void _openDetails(AssignmentModel assignment, StudentSubmissionModel? sub) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AssDetailsScreen(
          assignment: assignment,
          submission: sub,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredAssignments;

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeader(),
                SizedBox(height: 18.h),
                Text(
                  'Assignments',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colors.blue.shade500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Track your academic progress and upcoming deadlines.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.colors.sky.shade600,
                  ),
                ),
                SizedBox(height: 16.h),
                // Filter Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: InkWell(
                          onTap: () => setState(() => _selectedFilter = filter),
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 7.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.colors.sky.shade500
                                  : context.colors.sky.shade50,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                  ? Colors.white
                                  : context.colors.sky.shade700,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 18.h),
                if (_isLoading)
                  SizedBox(
                    height: 250.h,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  )
                else if (_errorMessage != null && _assignments.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.colors.grey.shade500,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Failed to load assignments',
                          style: TextStyle(
                            color: context.colors.error,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: _loadData,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else if (list.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: context.colors.grey.shade500,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'No ${_selectedFilter.toLowerCase()} assignments found.',
                        style: TextStyle(
                          color: context.colors.sky.shade600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      final assignment = list[index];
                      final sub = _findSubmission(assignment.assignmentId);
                      return _AssignmentCard(
                        assignment: assignment,
                        submission: sub,
                        onTap: () => _openDetails(assignment, sub),
                      );
                    },
                  ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;
  final StudentSubmissionModel? submission;
  final VoidCallback onTap;

  const _AssignmentCard({
    required this.assignment,
    required this.submission,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReviewed = submission?.score != null;
    final bool isSubmitted = submission != null && !isReviewed;
    final bool isNotSolved = submission == null;

    String badgeText;
    Color badgeBg;
    Color badgeColor;

    if (isReviewed) {
      badgeText = 'Reviewed';
      badgeBg = context.colors.green.withValues(alpha: 0.12);
      badgeColor = context.colors.green;
    } else if (isSubmitted) {
      badgeText = 'Submitted';
      badgeBg = const Color(0xFFFEF3C7);
      badgeColor = const Color(0xFFD97706);
    } else {
      badgeText = 'Not Solved';
      badgeBg = context.colors.sky.shade50;
      badgeColor = context.colors.sky.shade700;
    }

    return Container(
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
          // Top Row: Badge + Code/Assignment Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
              Icon(
                Icons.code,
                size: 18.sp,
                color: context.colors.sky.shade500,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Title
          Text(
            assignment.title ?? 'Assignment #${assignment.assignmentId}',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: context.colors.blue.shade500,
            ),
          ),
          SizedBox(height: 6.h),
          // Subtitle or Deadline
          if (isNotSolved)
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 13.sp,
                  color: context.colors.sky.shade600,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Due: ${formatShortDate(assignment.deadline)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.colors.sky.shade600,
                  ),
                ),
              ],
            )
          else if (isSubmitted)
            Row(
              children: [
                Icon(
                  Icons.hourglass_empty,
                  size: 13.sp,
                  color: const Color(0xFFD97706),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Under Review',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFD97706),
                  ),
                ),
              ],
            )
          else if (isReviewed)
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 14.sp,
                  color: context.colors.green,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Score: ${submission!.score!.toStringAsFixed(0)}/100',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colors.blue.shade500,
                  ),
                ),
              ],
            ),
          SizedBox(height: 14.h),
          // Button
          SizedBox(
            width: double.infinity,
            height: 38.h,
            child: isNotSolved
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.sky.shade500,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: onTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Assignment',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.colors.sky.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: onTap,
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
