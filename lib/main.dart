import 'package:blog_app/blog_view.dart';
import 'package:blog_app/firebase_options.dart';
<<<<<<< HEAD
import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/models/fetch_blog.dart';
import 'package:blog_app/navigation.dart';
import 'package:blog_app/profile.dart';
import 'package:blog_app/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
import 'package:blog_app/profile.dart';
import 'package:blog_app/splash.dart';
>>>>>>> e844433fbc0281b0e26edda5c1830796f85050fb
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser==null?const SplashScreen(): Navigation(),
    );
  }
}
