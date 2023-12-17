import 'package:job_search_app_frontend/views/video_player/video_player_view.dart';
import 'package:video_player/video_player.dart';

import '../../common/export.dart';

class VideoPlayersScreen extends StatelessWidget {
  const VideoPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const CustomAppbar(title: "Vài mẹo kiếm việc")),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(height: 2.h),
          const VideoPlayerView(
            name: 'I wish every Job Seeker would watch this',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%20I%20wish%20every%20Job%20Seeker%20would%20watch%20this_1080p.mp4?alt=media&token=1a48bfd1-706a-44f1-85fb-43ff0b1ef063',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name: '7 Job Search Strategies To Find  A Job FAST',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%207%20Job%20Search%20Strategies%20To%20Find%20%20A%20Job%20FAST_1080p.mp4?alt=media&token=445d13ff-1c43-473f-a154-63b608a6e84b',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name:
                'Tìm việc IT giữa làn sóng sa thải 2023. Tip tìm việc cho junior',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%20T%C3%ACm%20vi%E1%BB%87c%20IT%20gi%E1%BB%AFa%20l%C3%A0n%20s%C3%B3ng%20sa%20th%E1%BA%A3i%202023%20%20Tip%20t%C3%ACm%20vi%E1%BB%87c%20cho%20junior_1080p.mp4?alt=media&token=7a27cc90-c625-4267-a238-616d327cc5a4',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name:
                'Job Search Strategies and Techniques  How To MASTER Your Job Search',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%20Job%20Search%20Strategies%20and%20Techniques%20%20How%20To%20MASTER%20Your%20Job%20Search_1080p.mp4?alt=media&token=168753a2-581f-40a8-ae6c-b96cdd6249b3',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name:
                'Chiếc CV này đã giúp mình nhận Vài Chục Offer và có Job Ngon',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%20Chi%E1%BA%BFc%20CV%20n%C3%A0y%20%C4%91%C3%A3%20gi%C3%BAp%20m%C3%ACnh%20nh%E1%BA%ADn%20V%C3%A0i%20Ch%E1%BB%A5c%20Offer%20v%C3%A0%20c%C3%B3%20Job%20Ngon_1080p.mp4?alt=media&token=f4456c46-7b67-4a4c-8c63-6f412a7508ae',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name: 'Đến tuổi muốn đầu tư còn gì ngoài bất động sản',
            url:
                'https://firebasestorage.googleapis.com/v0/b/job-search-app-84ada.appspot.com/o/jobee%2Ftips_cv_videos%2Fy2mate.com%20-%20%C4%90%E1%BA%BFn%20tu%E1%BB%95i%20mu%E1%BB%91n%20%C4%91%E1%BA%A7u%20t%C6%B0%20c%C3%B2n%20g%C3%AC%20ngo%C3%A0i%20b%E1%BA%A5t%20%C4%91%E1%BB%99ng%20s%E1%BA%A3n_1080p.mp4?alt=media&token=a82b463a-0070-412c-8160-fc29258d9118',
            dataSourceType: DataSourceType.network,
          ),
        ],
      ),
    );
  }
}
