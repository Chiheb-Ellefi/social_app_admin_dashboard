import 'package:dashboard/welcome/screen/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyAYMOn-2BYHufuGi7uI9UZV4d5vdNW7MIA",
      authDomain: "my-pfa-project.firebaseapp.com",
      projectId: "my-pfa-project",
      storageBucket: "my-pfa-project.appspot.com",
      messagingSenderId: "707243996515",
      appId: "1:707243996515:web:657282a46dbb2e8e06cf56");

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
      },
    );
  }
}
