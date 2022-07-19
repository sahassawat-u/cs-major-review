import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/main.dart';
import 'package:cs_major_review/pages/register_page.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  String? value;
  final items = ['Non-college', 'College'];
  @override
  void initState() {
    super.initState();
    _auth = context.read<FirebaseProvider>().getAuth();
    _firestore = context.read<FirebaseProvider>().getFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Hello', style: TextStyle(fontSize: 28)),
            SizedBox(
              height: 20,
            ),
            Text('Welcome to ...',
                style: TextStyle(fontSize: 15, color: kLoginSubTitle)),
            const SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  // color:
                  color: Color(0xff0B302C),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: TextField(
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  // color:
                  color: Color(0xff0B302C),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: TextField(
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  side: const BorderSide(color: kLoginSubTitle)),
              onPressed: () async {
                print('login with $email $password');
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    print('$email is in.');
                    final user = await _firestore
                        .collection('users')
                        .where('email', isEqualTo: email)
                        .get();
                    // user.docs[0].get('')
                    context.read<UserProvider>().initUser(
                        username: user.docs[0].get('username'),
                        role: user.docs[0].get('role'),
                        email: email,
                        forumDislikes: user.docs[0].get('forum_dislikes'),
                        forumLikes: user.docs[0].get('forum_likes'),
                        picture: user.docs[0].get('picture'));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(firstPage: false),
                        ));
                  } else {
                    print('login failed');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Sign in', style: TextStyle(color: kLoginButton)),
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Not a member ?'),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kLoginButton,
                    elevation: 0,
                    side: BorderSide(color: kLoginSubTitle),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ));
                  },
                  child: Text('Register', style: TextStyle()),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ],
        ));
  }
}
