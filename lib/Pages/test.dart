import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class favoriteEvent {
  final String name;
  final String place;
  final String img;

  favoriteEvent({required this.name, required this.place, required this.img});

  // Firestore ドキュメントから FavoriteEvent インスタンスを作成するファクトリーメソッド
  factory favoriteEvent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return favoriteEvent(
      name: data['name'],
      place: data['place'],
      img: data['img'],
    );
  }
}

// Firestore 初期化
Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}

// ユーザーの ID からお気に入りイベントの詳細を取得する関数
Future<List<favoriteEvent>> getFavoritesByUserId(String userId) async {
  final firestore = FirebaseFirestore.instance;

  // ユーザーの favorites フィールドからイベント ID のリストを取得
  final userDoc = await firestore.collection('users').doc(userId).get();
  final favoriteEventIds = List<String>.from(userDoc['favorites'] ?? []);

  // 各イベント ID を使ってイベントの詳細を取得
  final eventsQuery = await Future.wait(
    favoriteEventIds.map((eventId) => firestore.collection('events').doc(eventId).get()),
  );

  // ドキュメントから FavoriteEvent インスタンスを作成
  return eventsQuery.map((doc) {
    return favoriteEvent.fromFirestore(doc);
  }).toList();
}
