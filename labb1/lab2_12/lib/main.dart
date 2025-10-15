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
      title: 'Workout App',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Workout Programs'),
          backgroundColor: Colors.teal,
        ),
        body: const WorkoutList(),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  final List<Map<String, String>> workouts = const [
    {
      'title': 'Yoga for Beginners',
      'desc':
      'Start your wellness journey with yoga. Perfect for beginners who want to improve flexibility and calm the mind.',
      'image': 'assets/images/yoga.jpg',
    },
    {
      'title': 'Pilates Training',
      'desc':
      'Strengthen your core and improve posture with guided pilates exercises designed for all levels.',
      'image': 'assets/images/pilates.jpg',
    },
    {
      'title': 'Full Body Workout',
      'desc':
      'Boost your stamina and burn calories with our complete full body workout routine.',
      'image': 'assets/images/fullbody.jpg',
    },
    {
      'title': 'Stretching Routine',
      'desc':
      'Relax your muscles and prevent injuries with this daily stretching routine.',
      'image': 'assets/images/stretching.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: workouts.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: WorkoutItem(
              title: item['title']!,
              desc: item['desc']!,
              imagePath: item['image']!,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WorkoutItem extends StatelessWidget {
  final String title;
  final String desc;
  final String imagePath;

  const WorkoutItem({
    super.key,
    required this.title,
    required this.desc,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // BÊN TRÁI: NỘI DUNG
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // BÊN PHẢI: HÌNH ẢNH
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 180,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
