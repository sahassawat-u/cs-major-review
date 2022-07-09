import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/pages/login_page.dart';
import 'package:cs_major_review/pages/register_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback? onRegister;
  const WelcomePage({Key? key, required this.onRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // two images
            Image.asset(
              'images/dream2.jpeg',
              // width: 200,
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/dream1.jpeg',
              height: 200,
              // width: 200,
              // height: 200,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                'Discover your Dream CS major',
                textAlign: TextAlign.center,
                style: TextStyle(color: kLoginButton, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Explore existing universities that match your style',
                textAlign: TextAlign.center,
                style: TextStyle(color: kLoginSubTitle, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 125,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kLoginButton,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: Text('Register'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      side: BorderSide(color: kLoginButton),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child:
                        Text('Sign in', style: TextStyle(color: kLoginButton)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
