
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/main_sam_card.dart';
import '../../../../core/models/session_model.dart';
import '../../../../core/widgets/statistic_style.dart';
import '../../../../core/widgets/sub_sam_card.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../manager/admin_cubit.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final String userTrackId = '2';

          final remoteDataSource = AdminRemoteDataSourceImpl();
          final repository = AdminRepositoryImpl(
            remoteDataSource: remoteDataSource,
          );

          return AdminCubit(repository: repository)
            ..loadSessionsByTrackId(userTrackId);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_outlined),
              ),
              Text(
                AppString.session,
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppString.viewAndMangeSession,
                style: TextStyle(
                  color: context.colors.sky.shade700,
                  fontSize: 16,
                ),
              ),

              Expanded(
                child: BlocBuilder<AdminCubit, AdminState>(
                  builder: (context, state) {
                    if (state is AdminLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AdminError) {
                      return Center(
                        child: Text(
                          "NNNN${state.message}",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state is AdminSessionsLoaded) {
                      final List<SessionModel> sessions = state.sessions;

                      if (sessions.isEmpty) {
                        return const Center(child: Text('No sessions yet'));
                      }

                      return ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          final session = sessions[index];

                          return MainSamCard(
                            head: '${session.title} }',
                            onMenuTap: () {},
                            child: SubSamCard(
                              statistics: [
                                StatisticItem(
                                  title: 'duration ',
                                  content: statText(
                                    session.duration.toDouble(),
                                    title: ' Min',
                                    color: context.colors.sky.shade900,
                                  ),
                                ),
                                StatisticItem(
                                  title: 'link',
                                  content: statIcon(
                                    icon: Icons.open_in_new,
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(session.meetingLink!),
                                        mode: LaunchMode.inAppBrowserView,
                                      );
                                    },
                                  ),
                                ),
                                StatisticItem(
                                  title: 'date',
                                  content: statDate(
                                    session.date ?? '',
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
              CustomElevatedButton(
                text: AppString.addNewSession,
                onTap: () => context.push('/addSession'),
                borderRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
