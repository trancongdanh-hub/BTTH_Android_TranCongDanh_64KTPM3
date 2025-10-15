import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ButtonDemo(),
    );
  }
}

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút 1 - Màu xanh, hình capsule
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text('Button'),
            ),

            const SizedBox(height: 16),

            // Nút 2 - Màu đỏ, bo tròn
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text('Button'),
            ),

            const SizedBox(height: 16),

            // Nút 3 - Màu xanh nhạt
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text('Button'),
            ),

            const SizedBox(height: 16),

            // Nút 4 - Nút tròn to
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(120, 120), // nút vuông 120x120
                shape: const CircleBorder(),
              ),
              onPressed: () {},
              child: const Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}
