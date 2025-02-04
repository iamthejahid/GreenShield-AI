import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenshield_ai/core/router/error_page.dart';
import 'package:greenshield_ai/features/predict/view/predictscreen.dart';
import 'package:greenshield_ai/features/splashscreen/view/splashscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier();
});

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final router = ref.watch(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigator,
    debugLogDiagnostics: true,
    //     BuildConfig.instance.environment != Environment.PRODUCTION,
    refreshListenable: router,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: PredictScreen.path,
        name: PredictScreen.name,
        builder: (BuildContext context, GoRouterState state) =>
            const PredictScreen(),
      ),
    ],
    // initialLocation: HomePage.path,
    initialLocation: SplashScreen.path,
    errorPageBuilder: router._errorPageBuilder,
    redirect: (context, state) {
      return null;
    },
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier();

  Page<void> _errorPageBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: ErrorPage(
            state: state,
          ),
        ),
      );
}
