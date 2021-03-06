import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/main.dart';
import 'package:cs_major_review/pages/login_page.dart';
import 'package:cs_major_review/providers/firebase_provider.dart';
import 'package:cs_major_review/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String username = '';
  String password = '';
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  String? role;
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
            Text('Register for', style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 20,
            ),
            Text('your biggest journey with us',
                style: TextStyle(fontSize: 20, color: kLoginSubTitle)),
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
                    hintText: 'Email',
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
                    username = val;
                    // email = val;
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
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Type', style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: kLoginSubTitle, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      // isExpanded: true,
                      value: role,
                      // icon: const Icon(Icons.safety_check),
                      style: const TextStyle(color: kLoginSubTitle),
                      onChanged: (role) {
                        setState(() {
                          this.role = role;
                        });
                      },
                      items: items.map(buildMenuItem).toList()),
                ),
              ),
            ]),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kLoginButton,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () async {
                print('login with $email $password');
                try {
                  final auth = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (auth != null) {
                    Map<String, dynamic> data = {
                      'role': role,
                      'username': username,
                      'picture':
                          'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg',
                      'email': email,
                      'forum_likes': [],
                      'forum_dislikes': [],
                    };
                    await _firestore.collection('users').add(data);
                    // ignore: use_build_context_synchronously
                    context.read<UserProvider>().initUser(
                        username: username,
                        role: role ?? 'Non-college',
                        email: email,
                        forumDislikes: [],
                        forumLikes: [],
                        picture:
                            'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(firstPage: false),
                        ));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Register'),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
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
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child:
                      Text('Sign in', style: TextStyle(color: kLoginSubTitle)),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Alreaady have an account ?')
              ],
            ),
          ],
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: kLoginField, fontFamily: 'AveriaSerifLibre'),
      ));
}
