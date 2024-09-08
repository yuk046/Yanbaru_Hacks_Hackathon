// chat_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'gemini.dart'; // MessagesNotifierが定義されているファイルをインポート

class ChatController {
  final WidgetRef ref; // Riverpodのプロバイダにアクセスするための参照

  ChatController(this.ref);

   Future<String> sendYesNoChoice(bool choice) async {
    // MessagesNotifierクラスのreply関数を呼び出す
    final response = await ref.read(messagesNotifier.notifier).reply(choice);
    return response;
  }

     Future<String> sendPrompt() async {
    // MessagesNotifierクラスのreply関数を呼び出す
    final response = await ref.read(messagesNotifier.notifier).sendPrompt();
    return response;
  }

  Future<void> reset() async {
    // MessagesNotifierクラスのreply関数を呼び出す
    final response = await ref.read(messagesNotifier.notifier).reset();
  }
}


// ElevatedButton(
//               onPressed: () async {
//                 // 「はい」を送信する例
//                 final response = await chatController.sendYesNoChoice(true);
//                 print('AIの返答: $response');
//               },
//               child: Text('はい'),