import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenshield_ai/core/helpers/dismiss_keyboard.dart';
import 'package:greenshield_ai/core/router/router_notifier.dart';
import 'package:greenshield_ai/core/theme_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(360, 800 - 36),
      minTextAdapt: true,
      builder: (_, c) => DismissKeyboard(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,

          /// For preventing system dark.
          themeMode: ThemeMode.light,
          // theme:
          // themeProvider == "dark"
          //     ? const AppDarkTheme().themeData
          //     :
          // const AppTheme().themeData,
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          theme: AppTheme().themeData,
        ),
      ),
    );
  }
}
