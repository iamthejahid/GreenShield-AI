import 'package:flutter/material.dart';
import 'package:greenshield_ai/app/app.dart';
import 'package:greenshield_ai/app/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
