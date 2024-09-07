import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String?> readUserName(String documentId) async {
    try {
      // ドキュメントを取得
      DocumentSnapshot doc = await db.collection('Users').doc(documentId).get();

      // ドキュメントが存在するか確認
      if (doc.exists) {
        // ドキュメントから 'name' フィールドを取得
        final name = doc.get('name') as String?;
        print('取得した名前: $name');
        return name;
      } else {
        print('ドキュメントが存在しません');
        return null;
      }
    } catch (e) {
      print('ドキュメントの取得エラー: $e');
      return null;
    }
  }
}
