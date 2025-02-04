import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:greenshield_ai/core/service_location.dart' as service_locator;

class ProviderLog extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // log('\x1B[32m${newValue}\x1B[0m', name: '📟 NEW STATE 📟');
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };

  // final firebaseHandlerInstance = FirebaseHandler.instance;

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    log('', error: error, name: "ERROR");
    log('', error: stack, name: "ERROR STACK");

    return true;
  };

  await service_locator.init();

  runApp(
    ProviderScope(
      // parent: container,
      observers: [ProviderLog()],
      child: await builder(),
    ),
  );
}
