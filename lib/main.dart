import 'package:captura_lens/admin/admin_login.dart';
import 'package:captura_lens/photographer/photo_login_signup.dart';
import 'package:captura_lens/splash_screen.dart';
import 'package:captura_lens/try_to_do.dart';
import 'package:captura_lens/user/user_login_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '9_4_24.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Captura Lens',
      home: SplashScreen(),
    );
  }
}
