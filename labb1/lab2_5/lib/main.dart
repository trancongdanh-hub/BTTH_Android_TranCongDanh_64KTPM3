import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Detail UI',
      debugShowCheckedModeBanner: false,
      home: const CourseDetailPage(),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lessons = [
      {"title": "Introduction to Flutter", "duration": "20 min 50 sec"},
      {"title": "Installing Flutter on Windows", "duration": "20 min 50 sec"},
      {"title": "Setup Emulator on Windows", "duration": "20 min 50 sec"},
      {"title": "Creating Our First App", "duration": "20 min 50 sec"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail + Play button
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/flutter.png",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, size: 32, color: Colors.purple),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Course Info
              const Text(
                "Flutter Complete Course",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Created by Dear Programmer",
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                "55 Videos",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Tab Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text("Videos"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text("Description", style: TextStyle(color: Colors.purple)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lesson List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.play_circle_fill, color: Colors.purple),
                      title: Text(lesson["title"]!),
                      subtitle: Text(lesson["duration"]!),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
