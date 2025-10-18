import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../widgets/wall.dart';

class BallGamePage extends StatefulWidget {
  const BallGamePage({super.key});

  @override
  State<BallGamePage> createState() => _BallGamePageState();
}

class _BallGamePageState extends State<BallGamePage> {
  double ballX = 0;
  double ballY = 0;
  double targetX = 0.6;
  double targetY = -0.6;
  double ballSize = 30;
  bool gameOver = false;
  int seconds = 0;
  Timer? timer;
  late StreamSubscription<AccelerometerEvent> sub;

  @override
  void initState() {
    super.initState();
    startTimer();

    sub = accelerometerEvents.listen((event) {
      if (gameOver) return;

      setState(() {
        ballX += event.x * -0.02;
        ballY += event.y * 0.02;

        // giới hạn biên [-1, 1]
        ballX = ballX.clamp(-1.0, 1.0);
        ballY = ballY.clamp(-1.0, 1.0);
      });
    });
  }

  void startTimer() {
    seconds = 0;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  void resetGame() {
    Navigator.of(context).pop();
    setState(() {
      ballX = 0;
      ballY = 0;
      targetX = Random().nextDouble() * 1.6 - 0.8;
      targetY = Random().nextDouble() * 1.6 - 0.8;
      gameOver = false;
      startTimer();
    });
  }

  @override
  void dispose() {
    sub.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ⏱ Thời gian
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                '⏱ $seconds s',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 🧱 Khu vực tường và bóng
            Center(
              child: AspectRatio(
                aspectRatio: 1, // hình vuông
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;
                    final margin = 40;
                    final innerWidth = width - margin * 2;
                    final innerHeight = height - margin * 2;

                    // toạ độ chuyển đổi từ [-1,1] sang toạ độ thực
                    final ballLeft = margin + innerWidth / 2 + ballX * innerWidth / 2 - ballSize / 2;
                    final ballTop = margin + innerHeight / 2 + ballY * innerHeight / 2 - ballSize / 2;

                    final targetLeft = margin + innerWidth / 2 + targetX * innerWidth / 2 - 22.5;
                    final targetTop = margin + innerHeight / 2 + targetY * innerHeight / 2 - 22.5;

                    // kiểm tra chạm đích
                    if (!gameOver &&
                        (ballLeft - targetLeft).abs() < 25 &&
                        (ballTop - targetTop).abs() < 25) {
                      gameOver = true;
                      timer?.cancel();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('🎉 Hoàn thành!'),
                            content: Text('Thời gian: $seconds giây'),
                            actions: [
                              TextButton(
                                onPressed: resetGame,
                                child: const Text('Chơi lại'),
                              ),
                            ],
                          ),
                        );
                      });
                    }

                    return Stack(
                      children: [
                        // 🧱 Tường
                        Wall(margin: margin.toDouble()),

                        // 🎯 Đích
                        Positioned(
                          left: targetLeft,
                          top: targetTop,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.green, width: 4),
                            ),
                          ),
                        ),

                        // 🔴 Bóng
                        Positioned(
                          left: ballLeft,
                          top: ballTop,
                          child: Container(
                            width: ballSize,
                            height: ballSize,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
