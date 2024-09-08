import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:munimuniohagi/env/env.dart';

class Gemini {
  Future<String?> getText(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Env.key,
    );

    final content = [
      Content.text(prompt),
    ];

    final response = await model.generateContent(content);
    return response.text;
  }
}

void testGemini() async {
  final gemini = Gemini();
  final response = await gemini.getText("はいかいいえで考えられる質問を一つを考えてください");
  print(response);
}


