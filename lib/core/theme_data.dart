import 'package:greenshield_ai/core/helpers/ui_exporter.dart';

class AppTheme {
  ThemeData get themeData {
    return ThemeData(
        useMaterial3: true,
        inputDecorationTheme: _inputDecorationTheme,
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ));
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      border: const OutlineInputBorder(),

      // prefixIconColor: AppColors.mediumEmphasisSurface,
      // hoverColor: AppColors.inputHover,
      // focusColor: AppColors.inputFocused,
      // fillColor: AppColors.inputEnabled,
      // enabledBorder: _textFieldBorder,
      focusedBorder: _textFieldBorder,

      // border: const UnderlineInputBorder(),
      // border: OutlineInputBorder(),
      filled: true,
      isDense: true,
      // errorStyle: UITextStyle.caption,
    );
  }

  InputBorder get _textFieldBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: AppColors.primary,
        ),
      );
}
