import 'package:crime_reporter/pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CrimeHome extends StatefulWidget {
  const CrimeHome({Key? key}) : super(key: key);

  @override
  State<CrimeHome> createState() => _CrimeHomeState();
}

class _CrimeHomeState extends State<CrimeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Crime Reporter',
                  style: GoogleFonts.quantico(color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => const Login());
                    Get.snackbar('Log out', 'You have logged out.', backgroundColor: const Color.fromRGBO(255,69 ,0, 0.4));

                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                )
              ],
            ),
            backgroundColor: const Color(0xff161650)),
      body: Container(
        alignment: Alignment.center,
        child: const Icon(MdiIcons.sword, color: Colors.green, size: 500,),
      )

    );
  }
}
