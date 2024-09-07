import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/test.dart';

class favorite extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // フックを使って状態を管理
    final favoriteEvents = useState<List<favoriteEvent>>([]);
    final userId = 'exampleUserId'; // 実際のユーザー ID に置き換えてください

    useEffect(() {
      // Firestore からデータを取得
      Future<void> fetchData() async {
        try {
          final events = await getFavoritesByUserId(userId);
          favoriteEvents.value = events;
        } catch (e) {
          print('Error fetching data: $e');
        }
      }
      
      fetchData();
      return null; // Clean up function, not needed here
    }, []);

    return ListView.builder(
      itemCount: favoriteEvents.value.length,
      itemBuilder: (context, index) {
        final event = favoriteEvents.value[index];

        return Container(
          margin: EdgeInsets.all(10), // 四角形の外側の余白
          decoration: BoxDecoration(
            color: Colors.white, // 背景色
            borderRadius: BorderRadius.circular(15), // 角を丸くする
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // 影の位置
              ),
            ],
            border: Border.all(color: Color(0xffE2C6FF), width: 4), // 四角形の枠線
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // 四角形内の余白
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // 画像の角を丸くする
                  child: Image.network(
                    event.img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10), // テキストと画像の間のスペース
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.place,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
