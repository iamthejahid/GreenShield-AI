import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class DeepSeekRepo {
  Future<String?> sendMessageToDeepSeek({
    required String message,
  });
}

class DeepSeekRepoImpl implements DeepSeekRepo {
  @override
  Future<String?> sendMessageToDeepSeek({required String message}) async {
    try {
      // Send message to DeepSeek
      final url = Uri.parse('https://api.deepseek.com/v1/chat');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY',
      };

      final body = jsonEncode({
        'messages': [
          {
            'role': 'system',
            'content':
                '''You are a helpful agricultural assistant. When I provide you with the name of a plant disease or pest, respond in Bengali with the following format:
                    1. A small description of the disease/pest.
                    2. Symptoms (লক্ষণ) enclosed between `#1# লক্ষণ #1#`.
                    3. Prevention and treatment (প্রতিরোধ ও প্রতিকার) enclosed between `#2# প্রতিরোধ ও প্রতিকার #2#`.
                    Ensure the response is clear, concise, and in Bengali. Use simple language for better understanding''',
          },
          {
            'role': 'user',
            'content': message,
          },
        ],
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Parse the response
        final responseData = jsonDecode(response.body);
        return responseData['choices'][0]['message']['content'];
      }
    } catch (e, err) {
      log(
        "",
        error: e,
        stackTrace: err,
        name: "DeepSeekRepoImpl.sendMessageToDeepSeek",
      );
    }
    return null;
  }
}
