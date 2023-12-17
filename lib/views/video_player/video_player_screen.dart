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
                'https://res.cloudinary.com/sofiathefck/video/upload/v1702834854/job_seekers_y9fy8u.mp4',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name: '7 Job Search Strategies To Find  A Job FAST',
            url:
                'https://res.cloudinary.com/sofiathefck/video/upload/v1702834866/y2mate.com_-_7_Job_Search_Strategies_To_Find_A_Job_FAST_1080p_msggvj.mp4',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name:
                'Chiếc CV này đã giúp mình nhận Vài Chục Offer và có Job Ngon',
            url:
                'https://res.cloudinary.com/sofiathefck/video/upload/v1702834875/vai_chuc_offers_bjmjdg.mp4',
            dataSourceType: DataSourceType.network,
          ),
          SizedBox(height: 5.h),
          const VideoPlayerView(
            name: 'Đến tuổi muốn đầu tư còn gì ngoài bất động sản',
            url:
                'https://res.cloudinary.com/sofiathefck/video/upload/v1702834847/y2mate.com_-_%C4%90%E1%BA%BFn_tu%E1%BB%95i_mu%E1%BB%91n_%C4%91%E1%BA%A7u_t%C6%B0_c%C3%B2n_g%C3%AC_ngo%C3%A0i_b%E1%BA%A5t_%C4%91%E1%BB%99ng_s%E1%BA%A3n_1080p_lvoswp.mp4',
            dataSourceType: DataSourceType.network,
          ),
        ],
      ),
    );
  }
}
