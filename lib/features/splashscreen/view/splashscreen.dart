import 'package:greenshield_ai/core/helpers/ui_exporter.dart';

class SplashScreen extends StatelessWidget {
  static String get name => '/SplashScreen';
  static String get path => '/SplashScreen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
