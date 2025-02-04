import 'package:http/http.dart' as http;

class InternetConnectionChecker {
  // Singleton instance
  static final InternetConnectionChecker instance =
      InternetConnectionChecker._();
  InternetConnectionChecker._();

  // Checker
  Future<bool> isOnline() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.bbc.com/'))
          .timeout(const Duration(seconds: 30));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
