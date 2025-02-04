import 'dart:developer';
import 'package:flutter/services.dart';
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
    // api key load from the assets
    final apiKey = await rootBundle.loadString('assets/t_assets/api_key.txt');

    try {
      // Send message to DeepSeek
      final url = Uri.parse('https://api.openai.com/v1/chat/completions');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        "Charset": "utf-8",
      };

      final body = jsonEncode({
        'model': "gpt-4o-mini",
        'messages': [
          {
            'role': 'system',
            'content':
                '''You are a helpful agricultural assistant. When I provide you with the name of a plant disease or pest, respond in Bengali with the following format:
                    1. A small description of the disease/pest.
                    2. Symptoms (লক্ষণ) enclosed between `#1# লক্ষণ #1#`.
                    3. Prevention and treatment (প্রতিরোধ ও প্রতিকার) enclosed between `#2# প্রতিরোধ ও প্রতিকার #2#`.
                    Ensure the response is clear, concise, and in Bengali. Use simple language for better understanding
                    Also if you get something is not disease, like healthy plant, then you can respond in
                    1. simple description how to keep plant healthy.
                    2. Symptoms of healthy plant, Symptoms (লক্ষণ) enclosed between `#1# লক্ষণ #1#`.
                    3. Prevention and treatment for unhealthy plant, Prevention and treatment (প্রতিরোধ ও প্রতিকার) enclosed between `#2# প্রতিরোধ ও প্রতিকার #2#`
                    .
                    ''',
          },
          {
            'role': 'user',
            'content': message,
          },
        ],
      });

      final response = await http.post(url, headers: headers, body: body);
      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        // Parse the response
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
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
