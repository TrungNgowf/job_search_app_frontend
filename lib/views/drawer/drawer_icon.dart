import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_search_app_frontend/common/export.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ZoomDrawer.of(context)!.toggle();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 6.w, top: 2.h),
          child: const FaIcon(
            FontAwesomeIcons.bars,
            color: Colors.black,
          ),
        ));
  }
}
