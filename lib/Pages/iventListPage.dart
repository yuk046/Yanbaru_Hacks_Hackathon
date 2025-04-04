import 'dart:convert'; // JSONデータのエンコーディングに使用
import 'dart:io'; // CSVのファイル操作に使用
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/constant/constant.dart';
import 'package:path_provider/path_provider.dart';

class EventListPage extends HookWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // イベントデータを保持するためのState
    final eventList = useState<List<Map<String, dynamic>>>([]);
    final isLoading = useState<bool>(true);

    // Firestoreからイベントを取得
    useEffect(() {
      _getEvent(eventList, isLoading);
      return null; // クリーンアップ関数（今回は不要）
    }, []); // 初回のみ実行

    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEvent(eventList, isLoading);
            },
          ),
        ],
      ),
      body: isLoading.value
          ? Center(child: CircularProgressIndicator()) // データがロードされるまでローディング表示
          : eventList.value.isEmpty
              ? Center(child: Text('No events available'))
              : ListView.builder(
                  itemCount: eventList.value.length,
                  itemBuilder: (context, index) {
                    final event = eventList.value[index];
                    return Card(
                      child: ListTile(
                        title: Text(event['name']),
                        subtitle:
                            Text('場所: ${event['place']}\n日付: ${event['date']}'),
                        trailing: event['img'].isNotEmpty
                            ? Image.network(event['img'], width: 50, height: 50)
                            : null,
                      ),
                    );
                  },
                ),
      backgroundColor: Color(Constant.mainBackGroundColor),
    );
  }

  // Firestoreからデータを取得してイベントリストに追加
  Future<void> _getEvent(
    ValueNotifier<List<Map<String, dynamic>>> eventList,
    ValueNotifier<bool> isLoading,
  ) async {
    isLoading.value = true;
    try {
      QuerySnapshot getDate = await FirebaseFirestore.instance
          .collection('Event')
          .orderBy('date', descending: false)
          .get();

      // 取得したデータをリストに変換してセット
      final events = getDate.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        final baseTime = (data['date'] as Timestamp).toDate();
        final addNineHours = baseTime.add(
          const Duration(
            hours: 9,
          ),
        );
        return {
          'id' : doc.id,
          'date': addNineHours,
          'img': data['img'],
          'name': data['name'],
          'place': data['place']
        };
      }).toList();

      // 取得したデータをstateに保存
      eventList.value = events;

      // CSV形式に変換
      List<List<dynamic>> rows = [];
      rows.add(['id','Name', 'Date', 'Place', 'Image']); // ヘッダー行
      for (var event in events) {
        rows.add([
          event['id'],
          event['name'],
          event['date'].toString(), // DateTime を文字列に変換
          event['place'],
          event['img']
        ]);
      }
      

      Future<void> generateCsvAsync(List<List<dynamic>> rows) async {
          // CSV形式に変換
          String csv = const ListToCsvConverter(eol: '\n').convert(rows);

          // アプリケーションのドキュメントディレクトリを取得
          final directory = await getApplicationDocumentsDirectory();
          final path = '${directory.path}/events.csv'; // 保存するファイルのパス
          final file = File(path);

          // CSVデータをファイルに書き込み
          await file.writeAsString(csv);

          print('CSVファイルが保存されました: $path');
        }

        
      generateCsvAsync(rows);
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }

  }
}
