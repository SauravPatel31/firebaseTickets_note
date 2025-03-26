import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note/a.dart';
import 'package:firebase_note/auth_provider.dart';
import 'package:firebase_note/delivery_add_page.dart';
import 'package:firebase_note/firebase_options.dart';
import 'package:firebase_note/home_page.dart';
import 'package:firebase_note/login_page.dart';
import 'package:firebase_note/notify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth(),)
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: LoginPage(),
    );
  }
}

