import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_admin/views/pages/main_page.dart';


// flutter run -d chrome --web-renderer html

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: "AIzaSyD-C34XTjEMpGZgV9Bg3p59_7nobkzeBjw",
              appId: "1:279393469363:web:256605fffd4eaa136381c6",
              messagingSenderId: "279393469363",
              projectId: "smartshop-288b8",
              storageBucket: "smartshop-288b8.appspot.com",
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      builder: EasyLoading.init(),
    );
  }
}
