import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const UploadImageApp());
}

class UploadImageApp extends StatefulWidget {
  const UploadImageApp({super.key});

  @override
  State<UploadImageApp> createState() => _UploadImageAppState();
}

class _UploadImageAppState extends State<UploadImageApp> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    // 1️⃣ Upload lên Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('blog_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(_image!);
    final url = await ref.getDownloadURL();

    // 2️⃣ Lưu URL vào Firestore
    await FirebaseFirestore.instance.collection('blogs').add({
      'title': 'Bài viết có ảnh',
      'content': 'Nội dung ví dụ',
      'feature_image': url, // 💡 đây là trường mới bạn cần thêm
      'created_at': DateTime.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Upload và lưu thành công!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Upload ảnh bài viết')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text('Chưa chọn ảnh')
                  : Image.file(_image!, height: 150),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Chọn ảnh'),
              ),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Upload lên Firebase'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
