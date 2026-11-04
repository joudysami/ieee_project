import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/constant/admin_config.dart';
import 'package:ieee/core/models/track_model.dart';
import 'package:ieee/feature/student/data/datasources/student_remote_data_source.dart';
import 'package:ieee/feature/student/data/repositories/student_repository_impl.dart';
import 'package:ieee/feature/student/data/student_config.dart';
import 'package:ieee/feature/student/domain/repositories/student_repository.dart';
import 'package:ieee/feature/student/presentation/screens/track_details_screen.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';

class TracksScreenStu extends StatefulWidget {
  const TracksScreenStu({super.key});

  @override
  State<TracksScreenStu> createState() => _TracksScreenStuState();
}

class _TracksScreenStuState extends State<TracksScreenStu> {
  final StudentRepository _repository = StudentRepositoryImpl(
    remoteDataSource: StudentRemoteDataSourceImpl(),
  );
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  String? _errorMessage;
  List<TrackModel> _allTracks = [];
  List<TrackModel> _filteredTracks = [];
  late final int _enrolledTrackId;

  @override
  void initState() {
    super.initState();
    _enrolledTrackId = StudentConfig.resolveTrackId();
    _loadTracks();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTracks = List.from(_allTracks);
      } else {
        _filteredTracks = _allTracks.where((track) {
          final name = (track.name ?? '').toLowerCase();
          final desc = (track.description ?? '').toLowerCase();
          return name.contains(query) || desc.contains(query);
        }).toList();
      }
    });
  }

  Future<void> _loadTracks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final List<TrackModel> loaded = [];

      // Query known tracks from AdminConfig (1..5)
      for (final entry in AdminConfig.tracks.entries) {
        final id = int.tryParse(entry.value);
        if (id == null) continue;
        try {
          final t = await _repository.getTrackById(id);
          loaded.add(t);
        } catch (_) {
          // Fallback if backend does not have specific ID
          loaded.add(
            TrackModel(
              trackId: id,
              name: entry.key,
              description: 'Comprehensive curriculum for ${entry.key}',
            ),
          );
        }
      }

      // Sort so enrolled track is at the top
      loaded.sort((a, b) {
        if (a.trackId == _enrolledTrackId) return -1;
        if (b.trackId == _enrolledTrackId) return 1;
        return a.trackId.compareTo(b.trackId);
      });

      if (!mounted) return;
      setState(() {
        _allTracks = loaded;
        _filteredTracks = loaded;
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

  void _openTrackDetails(TrackModel track) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TrackDetailsScreen(
          track: track,
          isEnrolled: track.trackId == _enrolledTrackId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadTracks,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeader(),
                SizedBox(height: 18.h),
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.grey.shade500,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: context.colors.sky.shade100),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for tracks...',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: context.colors.sky.shade600,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.colors.sky.shade600,
                        size: 20.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                if (_isLoading)
                  SizedBox(
                    height: 300.h,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  )
                else if (_errorMessage != null && _allTracks.isEmpty)
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Failed to load tracks',
                            style: TextStyle(
                              color: context.colors.error,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: _loadTracks,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_filteredTracks.isEmpty)
                  SizedBox(
                    height: 200.h,
                    child: Center(
                      child: Text(
                        'No tracks found matching your search.',
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
                    itemCount: _filteredTracks.length,
                    separatorBuilder: (_, __) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      final track = _filteredTracks[index];
                      final isEnrolled = track.trackId == _enrolledTrackId;
                      return _TrackCard(
                        track: track,
                        isEnrolled: isEnrolled,
                        onTap: () => _openTrackDetails(track),
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

class _TrackCard extends StatelessWidget {
  final TrackModel track;
  final bool isEnrolled;
  final VoidCallback onTap;

  const _TrackCard({
    required this.track,
    required this.isEnrolled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trackName = track.name ?? 'Track';
    final subtitleInfo = isEnrolled
        ? 'Advanced | 1,240 Students'
        : (track.description != null && track.description!.isNotEmpty
              ? track.description!
              : 'Beginner | 2,410 Students');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isEnrolled
                ? context.colors.sky.shade200
                : context.colors.sky.shade100,
            width: isEnrolled ? 1.5 : 1,
          ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Enrolled Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isEnrolled
                        ? context.colors.sky.shade50
                        : context.colors.grey.shade500,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isEnrolled
                          ? context.colors.sky.shade300
                          : context.colors.grey.shade600,
                    ),
                  ),
                  child: Text(
                    isEnrolled ? 'Enrolled' : 'Not Enrolled',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: isEnrolled
                          ? context.colors.sky.shade700
                          : context.colors.grey.shade800,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: context.colors.sky.shade500,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              trackName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: context.colors.blue.shade500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitleInfo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colors.sky.shade600,
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              height: 38.h,
              child: isEnrolled
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.sky.shade500,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: onTap,
                      child: Text(
                        'Continue Track',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.white,
                        ),
                      ),
                    )
                  : OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.colors.blue.shade500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: onTap,
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.blue.shade500,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
