import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'import_blogs.dart';
import 'package:tlu_firebase/import_blogs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Firestore Import Blogs')),
        body: const Center(
          child: Text('Blogs imported successfully!'),
        ),
      ),
    );
  }
}
