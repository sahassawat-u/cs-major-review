import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:cs_major_review/widgets/forum_category.dart';
import 'package:cs_major_review/widgets/profile_picture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  String name;
  final String picture;
  EditProfilePage({Key? key, required this.name, required this.picture})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String editedName;
  late FirebaseFirestore _firestore;
  PlatformFile? pickedFile;
  bool isUpload = false;
  UploadTask? uploadTask;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _firestore = context.read<FirebaseProvider>().getFirestore();
    controller.text = widget.name;
    editedName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          shrinkWrap: true,
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
                Spacer(flex: 2),
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Spacer(flex: 2),
                IconButton(onPressed: submitEditing, icon: Icon(Icons.check))
              ],
            ),
            Container(
              child: Text("Name"),
            ),
            Container(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  // print(widget.name);
                  setState(() {
                    editedName = value;
                  });
                  // print(editedName);
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text("Picture"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: pickedFile == null
                    ? ProfilePicture(
                        picture: widget.picture, width_: 100, height_: 300)
                    : ClipOval(
                        child: Image.file(
                          File(pickedFile!.path!),
                          width: 100,
                          height: 300,
                        ),
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ForumCategory(
                  onPressed_: selectFile,
                  text: "Select Picture",
                  isSelected: true,
                ),
                SizedBox(
                  width: 30,
                ),
                ForumCategory(
                  onPressed_: uploadFile,
                  text: "Upload Picture",
                  isSelected: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submitEditing() async {
    if (editedName == widget.name) {
      Navigator.pop(context);
      return;
    }
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    print(to_process_db_user);
    // print(context.read<UserProvider>().getEmail());
    for (var i = 0; i < to_process_db_user.docs.length; i++) {
      if (to_process_db_user.docs[i]['email'] ==
          context.read<UserProvider>().getEmail()) {
        _firestore
            .collection('users')
            .doc(to_process_db_user.docs[i].id)
            .set({'username': editedName}, SetOptions(merge: true));
        context.read<UserProvider>().setName(editedName);

        // print(to_process_db_user.docs[i]['username']);
      }
    }
    Navigator.pop(context);
  }

  Future selectFile() async {
    final res = await FilePicker.platform.pickFiles(withData: true);
    if (res == null) return;

    pickedFile = res.files.first;
    setState() {
      pickedFile = res.files.first;
    }
  }

  Future uploadFile() async {
    if (pickedFile == null) return;
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    // print(Path.basename(path));
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    final to_process_db_user = await _firestore
        .collection('users')
        .where(context.read<UserProvider>().getEmail())
        .get();
    for (var i = 0; i < to_process_db_user.docs.length; i++) {
      if (to_process_db_user.docs[i]['email'] ==
          context.read<UserProvider>().getEmail()) {
        _firestore
            .collection('users')
            .doc(to_process_db_user.docs[i].id)
            .set({'picture': urlDownload}, SetOptions(merge: true));
        context.read<UserProvider>().updatePicture(urlDownload);

        // print(to_process_db_user.docs[i]['username']);
      }
    }
    // print(to_process_db_user.docs[]);
  }
}
