import 'package:job_search_app_frontend/common/export.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CVFromNetwork extends StatelessWidget {
  final String pdfURL;

  const CVFromNetwork({super.key, required this.pdfURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const CustomAppbar(
            title: 'Curriculum Vitae',
          ),
        ),
        body: SfPdfViewer.network(pdfURL));
  }
}
