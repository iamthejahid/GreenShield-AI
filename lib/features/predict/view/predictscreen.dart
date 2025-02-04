import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';

class PredictScreen extends StatelessWidget {
  static String get name => '/PredictScreen';
  static String get path => '/PredictScreen';
  const PredictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primary,
        title: Text(
          'Greenshield AI',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Spacer(),
          Image.asset(
            "assets/capture.png",
            height: 200.w,
            width: 200.w,
          )
              .animate()
              .scale(
                duration: 0.5.seconds,
                curve: Curves.easeInOut,
              )
              .fadeIn(duration: 1.seconds),
          Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 6.w, horizontal: 48.w),
                  child: Text(
                    "Capture Image",
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Gap(12),
              Text(
                "Upload from Gallery",
                style: GoogleFonts.nunito(
                  fontSize: 14.sp,
                  color: const Color.fromARGB(255, 45, 82, 11),
                ),
              )
            ],
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 0.15.seconds)
              .slideY(begin: 1, end: 0, curve: Curves.easeOut),
          Spacer(),
        ],
      ),
    );
  }
}
