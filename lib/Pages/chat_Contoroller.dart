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
}
