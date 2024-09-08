import 'dart:convert'; // JSONデータのエンコーディングに使用
import 'dart:io'; // CSVのファイル操作に使用
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/constant/constant.dart';

class resultListPage extends HookWidget {
  const resultListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = useState<Map<String, dynamic>?>(null);
    final isLoading = useState<bool>(true);

    useEffect(() {
      _getOneEvent(event, isLoading);
      return null;
    }, []);

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3, // このContainerの比率を調整
            child: isLoading.value
                ? Center(child: CircularProgressIndicator())
                : event.value == null
                    ? Center(child: Text('No events available'))
                    : Container(
                        margin: EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (event.value!['img'] != null && event.value!['img'].isNotEmpty)
                                Image.network(
                                  event.value!['img'],
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.3, // 高さを画面の30%に設定
                                  fit: BoxFit.cover,
                                ),
                              ListTile(
                                title: Text(
                                  event.value!['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text('場所: ${event.value!['place']}\n日付: ${event.value!['date']}'),
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
          SizedBox(
            height: 30, // ボタンの上に空白を入れてスペースを確保
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // ボタンがタップされたときの処理をここに追加
                print('ボタンが押されました');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // ボタンを丸くする
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text(
                'もう一度！', // ボタンに表示するテキスト
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> _getOneEvent(
    ValueNotifier<Map<String, dynamic>?> event,
    ValueNotifier<bool> isLoading,
  ) async {
    isLoading.value = true;
    try {
      const specificEventId = 'HTg7fE57wLabUBmh4FpA';

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Event')
          .doc(specificEventId)
          .get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        final baseTime = (data['date'] as Timestamp).toDate();
        final addNineHours = baseTime.add(
          const Duration(
            hours: 9,
          ),
        );
        final eventData = {
          'date': addNineHours,
          'img': data['img'],
          'name': data['name'],
          'place': data['place']
        };

        event.value = eventData;

      } else {
        event.value = null;
      }
    } catch (e) {
      print('Error fetching event: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
