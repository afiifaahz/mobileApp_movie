import 'package:flutter/material.dart';
import 'package:ui/login.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() {
//   runApp(const MyApp());
// }
late FirebaseApp app;


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCi0Wr-e2EL8f5QxoQ2IKnvU5j8aJCRzrw", 
      appId: "1:296363262243:android:c0e37ed1a051e461e2cc96", 
      messagingSenderId: "296363262243", 
      projectId: "register-user-71902"));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
      ),
      home: SafeArea(child:  LoginPage()),
    );
  }
}




