import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:munimuniohagi/env/env.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final generativeModelProvider = Provider<GenerativeModel>((ref) => GenerativeModel(
  model: 'gemini-pro',
  apiKey: Env.key,
));

const gemini = types.User(id: 'gemini');
const me = types.User(id: 'user');

final messagesNotifier = StateNotifierProvider<MessagesNotifier, List<types.Message>>((ref) {
  return MessagesNotifier(ref.watch(generativeModelProvider).startChat());
});

class MessagesNotifier extends StateNotifier<List<types.Message>> {
  MessagesNotifier(this.chat) : super([]);

  late final ChatSession chat;

    /// 初期プロンプトを送信する関数
  Future<void> sendInitialPrompt() async {
    String data = ""; // エイサーイベントのデータ
    String prompt = 
      'ここに初期プロンプトを入れる ${data}';
    addMessage(me, prompt);
    final content = Content.text(prompt);
    try {
      final response = await chat.sendMessage(content);
      final message = response.text ?? 'プロンプトの実行に失敗しました。再試行してください。';
      addMessage(gemini, message);
    } catch (e) {
      addMessage(gemini, 'プロンプトの実行に失敗しました。再試行してください。');
    }
  }

  /// メッセージをリストに追加する関数
  void addMessage(types.User author, String text) {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final message = types.TextMessage(author: author, id: timeStamp, text: text);
    state = [message, ...state];
  }

  /// bool 型の引数で「はい」か「いいえ」を送信し、AIの応答を返す関数
  Future<String> reply(bool choice) async {
    final userMessage = choice ? 'はい' : 'いいえ';
    addMessage(me, userMessage);
    final content = Content.text(userMessage);
    String responseText = '';

    try {
      final response = await chat.sendMessage(content);
      responseText = response.text ?? '回答がありません。再試行してください。';
      addMessage(gemini, responseText);
    } catch (e) {
      responseText = 'エラーが発生しました。再試行してください。';
      addMessage(gemini, responseText);
    }

    return responseText;
  }
}



// class Gemini {
//   Future<String?> getText(String prompt) async {

//     final content = [
//       Content.text(prompt),
//     ];

//     final response = await model.generateContent(content);
//     return response.text;
//   }
// }


// class Geminireturn extends ConsumerWidget {
//   const Geminireturn({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     final gemini = ref.watch(geminiProvider);

//     final geminitext = gemini.when(
//       loading: () => const Text("loading"),
//       data: (data) => Text(data),
//       error: (error, stack) => Text("error"),
//     );

//     return Scaffold(
//     );
//   }
// }

