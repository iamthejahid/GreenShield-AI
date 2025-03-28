import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/core/widgets/custom_button.dart';
import 'package:greenshield_ai/core/widgets/decorated_container.dart';
import 'package:greenshield_ai/core/widgets/label_text.dart';
import 'dart:io';

import 'package:greenshield_ai/features/predict/view/predict_state_notifier.dart';

class ResultWidget extends HookConsumerWidget {
  const ResultWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final localState = ref.watch(predictStateProvider);
    final localStateController = ref.read(predictStateProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.w,
              width: double.infinity - 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                image: DecorationImage(
                  image: FileImage(File(localState.image!.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
                .animate()
                .scale(
                  duration: 0.5.seconds,
                  curve: Curves.easeInOut,
                )
                .fadeIn(duration: 1.seconds),
            Column(
              children: [
                Gap(16),
                DecoratedContainer(
                  width: double.infinity - 60.w,
                  color: AppColors.secondary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      CustomText(
                        text: "Diagnosis",
                        fontSize: 16.sp,
                      ),
                      Gap(8),
                      Row(
                        children: [
                          CustomText(
                            text: "Identified:",
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                          Spacer(),
                          CustomText(
                            text: "${localState.prediction}",
                            fontSize: 14.sp,
                            color: const Color.fromARGB(
                              255,
                              3,
                              104,
                              6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(16),
                DecoratedContainer(
                  width: double.infinity - 60.w,
                  color: AppColors.secondary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Analytical Insights",
                        fontSize: 16.sp,
                      ),
                      Gap(8),
                      Row(
                        children: [
                          CustomText(
                            text: "Confidence Level:",
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                          Spacer(),
                          CustomText(
                            text: "${localState.confidence}%",
                            fontSize: 14.sp,
                            color: const Color.fromARGB(
                              255,
                              3,
                              104,
                              6,
                            ),
                          ),
                        ],
                      ),
                      Gap(8),
                      Row(
                        children: [
                          Image.asset(
                            "assets/chat.png",
                            height: 80,
                            width: 80,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 0.15.seconds)
                .slideY(begin: 1, end: 0, curve: Curves.easeOut),
            Gap(16),
            CustomButton(
              onPressed: () {
                localStateController.reset();
              },
              text: "Reset",
              radius: 16.r,
            ),
            Gap(16),
            Row(
              children: [
                Spacer(),
                CustomText(text: "AI Response", fontSize: 16.sp),
                Gap(12),
                if (localState.isAiLoading ?? false)
                  SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
                Spacer(),
              ],
            ),
            Gap(16),
            if (localState.description != null)
              DecoratedContainer(
                child: Column(
                  children: [
                    Row(),
                    if (localState.description != null)
                      CustomText(
                        text: "${localState.description}",
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    Gap(8),
                    if (localState.symptoms != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          CustomText(
                            text: "লক্ষণ:",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: "${localState.symptoms}",
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    Gap(8),
                    if (localState.prevention != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          CustomText(
                            text: "প্রতিরোধ ও প্রতিকার:",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: "${localState.prevention}",
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    Gap(8),
                  ],
                ),
              ),
            Gap(16),
          ],
        ),
      ),
    );
  }
}
