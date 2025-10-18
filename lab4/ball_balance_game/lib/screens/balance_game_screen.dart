import 'package:flutter/material.dart';
import '../pages/ball_game_page.dart';

class BalanceGameScreen extends StatelessWidget {
  const BalanceGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: BallGamePage()),
    );
  }
}
