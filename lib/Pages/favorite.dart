import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/test.dart';

class favorite extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteEvents = useState<List<favoriteEvent>>([]);
    final isLoading = useState(true);
    final userId = 'exampleUserId'; // 実際のユーザーIDに置き換えてください

    useEffect(() {
      Future<void> fetchData() async {
        try {
          final events = await getFavoritesByUserId(userId);
          favoriteEvents.value = events;
          isLoading.value = false;
        } catch (e) {
          print('お気に入りイベントの取得中にエラーが発生しました: $e');
          isLoading.value = false;
        }
      }

      fetchData();
      return null; // Clean up function, not needed here
    }, []);

    if (isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: favoriteEvents.value.length,
      itemBuilder: (context, index) {
        final event = favoriteEvents.value[index];

        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(color: Color(0xffE2C6FF), width: 4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    event.img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.place,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
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