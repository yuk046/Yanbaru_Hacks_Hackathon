import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:munimuniohagi/env/env.dart';
import 'package:munimuniohagi/Pages/iventListPage.dart';
import '../utils/readCsvFile.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final generativeModelProvider =
    Provider<GenerativeModel>((ref) => GenerativeModel(
          model: 'gemini-pro',
          apiKey: Env.key,
        ));

const gemini = types.User(id: 'gemini');
const me = types.User(id: 'user');

final messagesNotifier =
    StateNotifierProvider<MessagesNotifier, List<types.Message>>((ref) {
  return MessagesNotifier(ref.watch(generativeModelProvider).startChat());
});

class MessagesNotifier extends StateNotifier<List<types.Message>> {
  MessagesNotifier(this.chat) : super([]);

  late final ChatSession chat;
  final prompt = "以上のようなエイサー祭りがあります。私は、ある「祭り」探しています。それを当てるための質問をしてください。あなたは5回質問をした後に、答えと思われるものを答えてください。また、ルールとして以下を設けます。・「はい」か「いいえ」で答えられる質問にしてください・祭りの名前を出すのは禁止です。・このエイサー祭りの開催時間はイギリス時間なので日本時間に直して考えてください。・質問する際は｛されますか？｝ではなく｛されるものがいいですか？｝にしてください。・質問をする際はQ＋質問番号＋質問文のみを出力してください・質問に対する回答にありがとうございますなどは出力しないでください・エイサー以外の伝統芸能を聞きたいときはエイサーが含まれていないことを明示してください・日付を直接聞くのは禁止です・１回あたり1つの質問を出力してください・質問をまとめて生成するのは禁止です";
  

    /// 初期プロンプトを送信する関数
  // Future<void> sendInitialPrompt() async {
    
  //   String data = ""; // エイサーイベントのデータ
  //   String prompt = "猫の名前を５つ考えてください";
  //     // 'ここに初期プロンプトを入れる ${data}';
  //   addMessage(me, prompt);
  //   final content = Content.text(prompt);
  //   try {
  //     final response = await chat.sendMessage(content);
  //     final message = response.text ?? 'プロンプトの実行に失敗しました。再試行してください。';
  //     addMessage(gemini, message);
  //   } catch (e) {
  //     addMessage(gemini, 'プロンプトの実行に失敗しました。再試行してください。');
  //   }
  // }

  /// メッセージをリストに追加する関数
  void addMessage(types.User author, String text) {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final message =
        types.TextMessage(author: author, id: timeStamp, text: text);
    state = [message, ...state];
  }


    Future<String> sendPrompt () async {
      Future<String> csvData = readCsvFile().catchError((err) {
      return "Error";
      });
      debugPrint("csvファイルを読み込み:$csvData");
    addMessage(me, "$csvData$prompt");
    final content = Content.text(prompt);
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

