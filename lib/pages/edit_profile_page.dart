import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // String currentName = _firestore.collection('users');
  // late FirebaseFirestore _firestore;

  // @override
  // void initState() {
  //   super.initState();
  //   initFirebase();
  // }
  // void initFirebase() async {
  //   await Firebase.initializeApp();
  //   // _auth = FirebaseAuth.instance;
  //   _firestore = FirebaseFirestore.instance;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
            height: 50,
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // Text("Back"),
              Spacer(flex:2),
              Text("Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),

              Spacer(flex:2),
              IconButton(onPressed: (){print("save");}, icon: Icon(Icons.check))

              ],
              ),

              Container(
              child: Text("Name"),
              ),
              Container(
                child: TextField(
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              Container(
              child: Text("University"),
              ),
            ],
        ),
      ),
    );
  }
}
