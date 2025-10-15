import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Buttons',
      debugShowCheckedModeBanner: false,
      home: const ButtonShowcasePage(),
    );
  }
}

class ButtonShowcasePage extends StatelessWidget {
  const ButtonShowcasePage({super.key});

  ButtonStyle rectangleButtonStyle({
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // bo góc nhẹ
        side: borderColor != null
            ? BorderSide(color: borderColor, width: 1)
            : BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Buttons"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Primary button
            ElevatedButton(
              style: rectangleButtonStyle(backgroundColor: Colors.blue),
              onPressed: () {},
              child: const Text("AppButton.primary()"),
            ),
            const SizedBox(height: 12),

            // Disabled primary button
            ElevatedButton(
              style: rectangleButtonStyle(backgroundColor: Colors.blue.shade200),
              onPressed: null,
              child: const Text("AppButton.primary() - disabled"),
            ),
            const SizedBox(height: 12),

            // Outlined button
            ElevatedButton(
              style: rectangleButtonStyle(
                backgroundColor: Colors.white,
                borderColor: Colors.black,
              ),
              onPressed: () {},
              child: const Text(
                "AppButton.outlined()",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 12),

            // Gradient button
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ElevatedButton(
                style: rectangleButtonStyle(backgroundColor: Colors.transparent),
                onPressed: () {},
                child: const Text("AppButton.gradient()"),
              ),
            ),
            const SizedBox(height: 12),

            // Accent gradient button
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.green],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ElevatedButton(
                style: rectangleButtonStyle(backgroundColor: Colors.transparent),
                onPressed: () {},
                child: const Text("AppButton.accentGradient()"),
              ),
            ),
            const SizedBox(height: 20),

            // Text button
            TextButton(
              onPressed: () {},
              child: const Text(
                "AppTextButton()",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            // Disabled text button
            TextButton(
              onPressed: null,
              child: Text(
                "disabled AppTextButton()",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
