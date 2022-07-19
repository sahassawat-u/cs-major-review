import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;

  void initFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
  }

  FirebaseFirestore getFirestore() {
    return _firestore;
  }

  FirebaseAuth getAuth() {
    return _auth;
  }
}
