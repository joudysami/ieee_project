import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/models/track_model.dart';
import 'package:ieee/feature/student/data/datasources/student_remote_data_source.dart';
import 'package:ieee/feature/student/data/repositories/student_repository_impl.dart';
import 'package:ieee/feature/student/domain/repositories/student_repository.dart';
import 'package:ieee/feature/student/presentation/screens/session_details_screen.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';

class TrackDetailsScreen extends StatefulWidget {
  final TrackModel track;
  final bool isEnrolled;

  const TrackDetailsScreen({
    super.key,
    required this.track,
    this.isEnrolled = false,
  });

  @override
  State<TrackDetailsScreen> createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  final StudentRepository _repository = StudentRepositoryImpl(
    remoteDataSource: StudentRemoteDataSourceImpl(),
  );

  bool _isLoading = true;
  String? _errorMessage;
  List<SessionModel> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final sessions = await _repository.getSessionsByTrackId(
        widget.track.trackId,
      );
      if (!mounted) return;
      setState(() {
        _sessions = sessions;
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

  void _openSessionDetails(SessionModel session) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SessionDetailsScreen(
          session: session,
          track: widget.track,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trackName = widget.track.name ?? 'Track Details';

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadSessions,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeader(showBackButton: true),
                SizedBox(height: 20.h),
                // Track Title
                Text(
                  trackName,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colors.blue.shade500,
                  ),
                ),
                SizedBox(height: 10.h),
                // Head / Instructor Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: context.colors.sky.shade100,
                      child: Icon(
                        Icons.person,
                        size: 16.sp,
                        color: context.colors.sky.shade700,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.colors.sky.shade600,
                        ),
                        children: [
                          const TextSpan(text: 'Head: '),
                          TextSpan(
                            text: 'IEEE Track Mentor',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: context.colors.blue.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // Sessions Section Header
                Text(
                  'Sessions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colors.blue.shade500,
                  ),
                ),
                SizedBox(height: 12.h),
                if (_isLoading)
                  SizedBox(
                    height: 200.h,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  )
                else if (_errorMessage != null && _sessions.isEmpty)
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
                          'Could not load sessions',
                          style: TextStyle(
                            color: context.colors.error,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: _loadSessions,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else if (_sessions.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: context.colors.grey.shade500,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'No sessions scheduled yet for this track.',
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
                    itemCount: _sessions.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final session = _sessions[index];
                      return _ModuleSessionTile(
                        index: index + 1,
                        session: session,
                        onTap: () => _openSessionDetails(session),
                      );
                    },
                  ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModuleSessionTile extends StatelessWidget {
  final int index;
  final SessionModel session;
  final VoidCallback onTap;

  const _ModuleSessionTile({
    required this.index,
    required this.session,
    required this.onTap,
  });

  String _getStatus() {
    final now = DateTime.now();
    final date = DateTime.tryParse(session.date ?? '');
    if (date == null) return 'Upcoming';
    if (date.isBefore(now.subtract(const Duration(hours: 3)))) {
      return 'Completed';
    }
    if (date.difference(now).inDays.abs() <= 1) {
      return 'In Progress';
    }
    return 'Upcoming';
  }

  @override
  Widget build(BuildContext context) {
    final status = _getStatus();
    final isCompleted = status == 'Completed';
    final isInProgress = status == 'In Progress';

    Color badgeBg;
    Color badgeText;
    if (isCompleted) {
      badgeBg = const Color(0xFFF3F4F6);
      badgeText = const Color(0xFF6B7280);
    } else if (isInProgress) {
      badgeBg = context.colors.sky.shade50;
      badgeText = context.colors.sky.shade700;
    } else {
      badgeBg = context.colors.grey.shade500;
      badgeText = context.colors.blue.shade500;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isInProgress
                ? context.colors.sky.shade200
                : context.colors.sky.shade100,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colors.shadow.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: context.colors.sky.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.play_lesson_outlined,
                size: 20.sp,
                color: context.colors.sky.shade600,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MODULE $index',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: context.colors.sky.shade600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    session.title ?? 'Session $index',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colors.blue.shade500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: badgeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
