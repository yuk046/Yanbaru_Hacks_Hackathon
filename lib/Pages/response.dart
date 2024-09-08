import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'response.g.dart';

@riverpod
class ResponseNotifier extends _$ResponseNotifier {
  @override
  String build() {
    // 最初のデータ
    return "Q0. 質問を表示する？";
  }
}
