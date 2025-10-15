import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Buttons Demo',
      home: const GradientButtonsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GradientButtonsScreen extends StatelessWidget {
  const GradientButtonsScreen({super.key});

  // Hàm tạo 1 nút gradient
  Widget buildGradientButton(String text, List<Color> colors) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Gradient Buttons",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildGradientButton("Click me 1", [Colors.green, Colors.teal]),
            buildGradientButton("Click me 2", [Colors.orange, Colors.red]),
            buildGradientButton("Click me 3", [Colors.blue, Colors.cyan]),
            buildGradientButton("Click me 4", [Colors.black54, Colors.grey]),
          ],
        ),
      ),
    );
  }
}
