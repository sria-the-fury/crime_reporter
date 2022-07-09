import 'package:crime_reporter/pages/Crime_Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        primary: const Color(0xff161650));

    _signInWithGoogle() async {

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var isSignIn =
        await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          if (isSignIn.additionalUserInfo?.isNewUser == true){
            Get.snackbar('Login', 'Welcome new user${user.email}',backgroundColor: const Color.fromRGBO(0, 255, 0, 0.4), );
          }
          Get.snackbar('Login', 'Welcome Dear,${user.email}',backgroundColor: const Color.fromRGBO(0, 255, 0, 0.4));
          Get.off(() => const CrimeHome());
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3))
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/CrimeReportLogo.png',
                      height: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'CRIME REPORTER',
                  style: GoogleFonts.quantico(fontSize: 34, color: const Color(0xff161650), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 50),
              ],
            )),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              _signInWithGoogle();
            },
            style: style,
            child: Row(
              children: [
                const Text('Sign in with'),
                Container(
                  height: 25,
                  width: 25,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/google_icon.png'),
                      )),
                )
              ],
            )),
        ElevatedButton(
            onPressed: () {
              Get.snackbar(
                'Error',
                'Hello There',backgroundColor: const Color.fromRGBO(255, 0, 0, 0.4),
              );
            },
            style: style,
            child: Row(
              children: const [
                Text('Sign up with  '),
                Icon(Icons.email),
              ],
            ))
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,);
  }
}
