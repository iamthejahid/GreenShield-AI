import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenshield_ai/core/router/error_page.dart';
import 'package:greenshield_ai/features/splashscreen/view/splashscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier();
});

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final router = ref.watch(routerNotifierProvider)..init();

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
    ],
    // initialLocation: HomePage.path,
    initialLocation: SplashScreen.path,
    errorPageBuilder: router._errorPageBuilder,
    redirect: (context, state) {
      // final loggedIn = router.isLoggedIn;
      // final routeInQ = router.nonAuthorizeList.contains(state.matchedLocation);
      // log(
      //   'loggedIn : $loggedIn || routeInQ : $routeInQ',
      //   name: '------------------|',
      // );

      // if (loggedIn) {
      //   return null;
      // } else {
      //   if (routeInQ) {
      //     return null;
      //   } else {
      //     return LoginScreen.path;
      //     // return null;
      //   }
      // }
      return null;
    },
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier();

  void init() {}

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  List<String> nonAuthorizeList = [];

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
