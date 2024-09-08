import 'package:path_provider/path_provider.dart';
import 'dart:io';


Future<String> readCsvFile() async {
    // アプリケーションのドキュメントディレクトリを取得
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/events.csv'; // 保存したCSVファイルのパス
    final file = File(path);

    if (await file.exists()) {
      // ファイルの内容を読み込む
      final csvContent = await file.readAsString();
      return csvContent;
    } else {
      print('CSVファイルが存在しません');
      throw Error();
    }
}
