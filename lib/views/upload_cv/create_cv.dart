import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:job_search_app_frontend/common/export.dart';
import 'package:job_search_app_frontend/controllers/cv_notifier.dart';
import 'package:job_search_app_frontend/models/response/profile_res.dart';
import 'package:job_search_app_frontend/views/job/job_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../common/export.dart';

class CreateCV extends StatelessWidget {
  final ProfileRes? profile;
  final String position;
  final String? imageUrl;
  final bool? isImageNetwork;

  const CreateCV(
      {super.key,
      this.profile,
      this.imageUrl,
      this.isImageNetwork,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: CustomAppbar(
          title: "Tạo mới CV",
          trailing: [
            GestureDetector(
              onTap: () async {
                List<String> finalFile = await savePdf();
                Provider.of<CVNotifier>(context, listen: false)
                    .setPdfName(finalFile[0]);
                Provider.of<CVNotifier>(context, listen: false)
                    .setPdfPath(finalFile[1]);
                Get.close(2);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(Icons.check_circle_outline_rounded,
                    color: Colors.green, size: 30.0),
              ),
            )
          ],
        ),
      ),
      body: PdfPreview(
        build: (format) =>
            _generatePdf(format, profile!, imageUrl!, "CV", isImageNetwork!),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, ProfileRes profile,
      String profilePic, String title, bool isNetworkImage) async {
    final pdf = pw.Document();
    final fontRegular = await PdfGoogleFonts.firaSansRegular();
    final fontBold = await PdfGoogleFonts.firaSansBold();
    final avatar = isNetworkImage
        ? await networkImage(profilePic)
        : pw.MemoryImage(File(profilePic).readAsBytesSync());
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.firaSansRegular(),
          bold: await PdfGoogleFonts.firaSansBold(),
          icons: await PdfGoogleFonts.materialIcons(),
          fontFallback: [
            await PdfGoogleFonts.firaSansRegular(),
            await PdfGoogleFonts.materialIcons()
          ],
        ),
        build: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                  flex: 4,
                  child: pw.Column(children: [
                    pw.Container(
                      width: 30.w, // Adjust size as needed
                      height: 30.w,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border:
                            pw.Border.all(color: PdfColors.green, width: 2.0),
                        image: pw.DecorationImage(
                          image: avatar,
                          fit: pw.BoxFit.fill,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 1.h),
                    _text(profile.username!, fontBold,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 5.sp,
                        color: PdfColors.green,
                        textAlign: pw.TextAlign.center),
                    pw.SizedBox(height: 1.h),
                    _text(
                      position,
                      fontRegular,
                      fontSize: 4.5.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    pw.SizedBox(height: 2.h),
                    pw.Container(
                        padding: pw.EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(5),
                            color: PdfColors.grey200),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Icon(
                                      pw.IconData(0xe616),
                                      color: PdfColors.green,
                                      size: 4.5.sp,
                                    ),
                                    pw.SizedBox(width: 3.w),
                                    _text(
                                        "${profile.dob!.day}/${profile.dob!.month}/${profile.dob!.year}",
                                        fontRegular,
                                        fontSize: 4.sp)
                                  ]),
                              pw.SizedBox(height: 1.h),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Icon(
                                      pw.IconData(0xe0b0),
                                      color: PdfColors.green,
                                      size: 4.5.sp,
                                    ),
                                    pw.SizedBox(width: 3.w),
                                    _text(profile.telephone!, fontRegular,
                                        fontSize: 4.sp)
                                  ]),
                              pw.SizedBox(height: 1.h),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisSize: pw.MainAxisSize.min,
                                  children: [
                                    pw.Icon(
                                      pw.IconData(0xe0be),
                                      color: PdfColors.green,
                                      size: 4.5.sp,
                                    ),
                                    pw.SizedBox(width: 3.w),
                                    pw.Expanded(
                                        child: _text(
                                            profile.email!, fontRegular,
                                            fontSize: 4.sp))
                                  ]),
                              pw.SizedBox(height: 1.h),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Icon(
                                      pw.IconData(0xe9b2),
                                      color: PdfColors.green,
                                      size: 4.5.sp,
                                    ),
                                    pw.SizedBox(width: 3.w),
                                    pw.Expanded(
                                        child: _text(
                                            profile.address!, fontRegular,
                                            fontSize: 4.sp))
                                  ]),
                              pw.SizedBox(height: 1.h),
                              profile.portfolio != null &&
                                      profile.portfolio != ""
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      children: [
                                          pw.Icon(
                                            pw.IconData(0xe873),
                                            color: PdfColors.green,
                                            size: 4.5.sp,
                                          ),
                                          pw.SizedBox(width: 3.w),
                                          _text(profile.portfolio!, fontRegular,
                                              fontSize: 4.sp)
                                        ])
                                  : pw.SizedBox(),
                            ])),
                  ])),
              pw.SizedBox(width: 3.w),
              pw.VerticalDivider(
                thickness: 2,
                color: PdfColors.green,
              ),
              pw.SizedBox(width: 3.w),
              pw.Expanded(
                flex: 7,
                child: pw.Container(
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                      _text("Học vấn", fontBold,
                          color: PdfColors.green, fontSize: 6.sp),
                      pw.SizedBox(height: 1.h),
                      _text(profile.education!, fontRegular, fontSize: 4.sp),
                      pw.SizedBox(height: 1.h),
                      _text(profile.major!, fontRegular, fontSize: 4.sp),
                      pw.SizedBox(height: 1.h),
                      _text(profile.degree!, fontRegular, fontSize: 4.sp),
                      pw.SizedBox(height: 2.h),
                      _text("Mục tiêu", fontBold,
                          color: PdfColors.green, fontSize: 6.sp),
                      pw.SizedBox(height: 1.h),
                      _text(profile.careerGoals!, fontRegular, fontSize: 4.sp),
                      pw.SizedBox(height: 2.h),
                      _text("Kinh nghiệm", fontBold,
                          color: PdfColors.green, fontSize: 6.sp),
                      pw.SizedBox(height: 1.h),
                      pw.Container(
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5),
                              color: PdfColors.grey200),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _text(profile.experiences![0], fontRegular,
                                    fontSize: 4.sp),
                                pw.SizedBox(height: 1.h),
                                _text(profile.experiences![1], fontRegular,
                                    fontSize: 4.sp),
                                pw.SizedBox(height: 1.h),
                                _text(profile.experiences![2], fontRegular,
                                    fontSize: 4.sp),
                              ])),
                      pw.SizedBox(height: 2.h),
                      _text("Kỹ năng", fontBold,
                          color: PdfColors.green, fontSize: 6.sp),
                      pw.SizedBox(height: 1.h),
                      pw.Container(
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5),
                              color: PdfColors.grey200),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _text(profile.skills![0], fontRegular,
                                    fontSize: 4.sp),
                                pw.SizedBox(height: 1.h),
                                _text(profile.skills![1], fontRegular,
                                    fontSize: 4.sp),
                                pw.SizedBox(height: 1.h),
                                _text(profile.skills![2], fontRegular,
                                    fontSize: 4.sp),
                              ])),
                      pw.SizedBox(height: 2.h),
                      profile.additionInfo != null && profile.additionInfo != ""
                          ? _text("Bổ sung", fontBold,
                              color: PdfColors.green, fontSize: 6.sp)
                          : pw.SizedBox(),
                      pw.SizedBox(height: 1.h),
                      profile.additionInfo != null && profile.additionInfo != ""
                          ? _text(profile.additionInfo!, fontRegular,
                              fontSize: 4.sp)
                          : pw.SizedBox(),
                    ])),
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  _text(String text, pw.Font font,
      {PdfColor? color,
      double? fontSize,
      pw.FontWeight? fontWeight,
      pw.TextAlign textAlign = pw.TextAlign.start}) {
    return pw.Text(
      text,
      textAlign: textAlign,
      style: pw.TextStyle(
        font: font,
        color: color ?? PdfColors.black,
        fontSize: fontSize ?? 4.sp,
        fontWeight: fontWeight ?? pw.FontWeight.bold,
      ),
    );
  }

  Future<List<String>> savePdf() async {
    final output = await getTemporaryDirectory();
    final file = File(
        "${output.path}/${profile!.username!.trim().replaceAll(" ", "")}_CV.pdf");
    final pdf = await _generatePdf(
        PdfPageFormat.a4, profile!, imageUrl!, "CV", isImageNetwork!);
    await file.writeAsBytes(pdf);
    return [
      "${profile!.username!.trim().replaceAll(" ", "")}_CV.pdf",
      file.path
    ];
  }
}
