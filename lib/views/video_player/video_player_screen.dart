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
        padding: const EdgeInsets.all(20),
        children: const [
          SizedBox(height: 24),
          // Network
          VideoPlayerView(
            url:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
            dataSourceType: DataSourceType.network,
          ),
        ],
      ),
    );
  }
}
