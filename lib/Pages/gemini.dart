// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// const apiKey = "AIzaSyAHtrmyvqtz0fPT6C629b94-ZLVtLtfim8";

// class Gemini {
//   Future<String?> getText(String prompt) async {
//     final model = GenerativeModel(
//       model: 'gemini-pro',
//       apiKey: apiKey,
//     );

//     final content = [
//       Content.text(prompt),
//     ];

//     final response = await model.generateContent(content);
//     return response.text;
//   }
// }

// void testGemini() async {
//   final gemini = Gemini();
//   final response = await gemini.getText("人気なスポーツを５つ答えてください");
//   print(response);
// }


