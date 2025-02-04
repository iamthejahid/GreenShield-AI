import 'package:google_fonts/google_fonts.dart';
import 'package:greenshield_ai/core/helpers/ui_exporter.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double? radius;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(radius ?? 4.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 48.w),
          child: Text(
            text,
            style: GoogleFonts.nunito(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
