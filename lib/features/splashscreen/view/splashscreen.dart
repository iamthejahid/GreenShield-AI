import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/features/predict/view/predictscreen.dart';

class SplashScreen extends HookConsumerWidget {
  static String get name => '/SplashScreen';
  static String get path => '/SplashScreen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    init() async {
      await Future.delayed(2.seconds).then((v) {
        if (context.mounted) {
          context.goNamed(PredictScreen.path);
        }
      });
    }

    useEffect(() {
      Future.microtask(() => init());
      return null;
    }, []);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
                  child: Image.asset(
            'assets/green_leaf.png',
            height: 120.w,
            width: 120.w,
          ))
              .animate()
              .scale(
                duration: 1.seconds,
                curve: Curves.easeInOut,
              )
              .fadeIn(duration: 1.seconds),
          Gap(36),
          Text(
            "Welcome to GreenShield AI!",
            style: GoogleFonts.nunito(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 1.seconds)
              .slideY(begin: 1, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }
}
