import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/core/widgets/custom_button.dart';
import 'package:greenshield_ai/core/widgets/loader.dart';
import 'package:greenshield_ai/features/predict/view/predict_state_notifier.dart';
import 'package:greenshield_ai/features/predict/view/widget/result_widget.dart';
import 'package:image_picker/image_picker.dart';

class PredictScreen extends HookConsumerWidget {
  static String get name => '/PredictScreen';
  static String get path => '/PredictScreen';
  const PredictScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final localState = ref.watch(predictStateProvider);
    final localController = ref.read(predictStateProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Greenshield AI',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            localState.prediction != null
                ? ResultWidget()
                : Column(
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
                          CustomButton(
                            onPressed: () {
                              localController.startPrediction(
                                  imageSource: ImageSource.camera);
                            },
                            text: "Capture Image",
                          ),
                          Gap(12),
                          TextButton(
                              onPressed: () {
                                localController.startPrediction(
                                    imageSource: ImageSource.gallery);
                              },
                              child: Text(
                                "Upload from Gallery",
                                style: GoogleFonts.nunito(
                                  fontSize: 14.sp,
                                  color: const Color.fromARGB(255, 45, 82, 11),
                                ),
                              )),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 0.15.seconds)
                          .slideY(begin: 1, end: 0, curve: Curves.easeOut),
                      Spacer(),
                    ],
                  ),
            if (localState.isLoading) Loader(),
          ],
        ));
  }
}
