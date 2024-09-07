import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> read() async {
    final doc = await db.collection('Event').doc('11ZPjFZR6wTviom8Tc8M').get();

    final event = doc.data().toString();
    debugPrint(event);
  }
}