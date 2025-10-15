import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ImportBlogsApp());
}

class ImportBlogsApp extends StatefulWidget {
  const ImportBlogsApp({super.key});

  @override
  State<ImportBlogsApp> createState() => _ImportBlogsAppState();
}

class _ImportBlogsAppState extends State<ImportBlogsApp> {
  String status = "⏳ Đang import dữ liệu...";

  @override
  void initState() {
    super.initState();
    importBlogs();
  }

  Future<void> importBlogs() async {
    try {
      // Đọc file blogs.json
      final jsonString = await rootBundle.loadString('blogs.json');
      final List<dynamic> data = jsonDecode(jsonString);

      final CollectionReference blogs =
      FirebaseFirestore.instance.collection('blogs');

      for (var item in data) {
        await blogs.add({
          'title': item['title'],
          'author': item['author'],
          'content': item['content'],
          'created_at': Timestamp.now(),
        });
      }

      setState(() {
        status = "✅ Import thành công ${data.length} blog(s)!";
      });

      print(status);
    } catch (e) {
      setState(() {
        status = "❌ Lỗi khi import: $e";
      });
      print(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Import Blogs to Firestore")),
        body: Center(child: Text(status, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}
