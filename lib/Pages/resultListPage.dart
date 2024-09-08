import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munimuniohagi/Pages/chat_Contoroller.dart';
import 'package:munimuniohagi/main.dart';

final eventProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
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

      return eventData;
    } else {
      return null;
    }
  } catch (e) {
    print('Error fetching event: $e');
    return null;
  }
});

class resultListPage extends ConsumerWidget {
  const resultListPage({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsyncValue = ref.watch(eventProvider);
    final chatController = ChatController(ref);

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3, // このContainerの比率を調整
            child: eventAsyncValue.when(
              data: (event) => event == null
                  ? Center(child: Text('No events available'))
                  : Container(
                      margin: EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (event['img'] != null && event['img'].isNotEmpty)
                              Image.network(
                                event['img'],
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.3, // 高さを画面の30%に設定
                                fit: BoxFit.cover,
                              ),
                            ListTile(
                              title: Text(
                                event['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text('場所: ${event['place']}\n日付: ${event['date']}'),
                            ),
                          ],
                        ),
                      ),
                    ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          SizedBox(
            height: 30, // ボタンの上に空白を入れてスペースを確保
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async => {
                // ボタンがタップされたときの処理をここに追加
                await chatController.reset(),
                print('ボタンが押されました'),
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(title: 'Home')),
                )
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
}
