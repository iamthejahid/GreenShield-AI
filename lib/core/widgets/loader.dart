import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/core/widgets/label_text.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/green_leaf.png",
              height: 120.w,
              width: 120.w,
            )
                .animate(
                    onPlay: (c) => c.repeat(
                          reverse: true,
                        ))
                .scaleXY(duration: 0.8.seconds, begin: 0.8, end: 1),
            Gap(16),
            CustomText(
              text: "Loading...",
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
