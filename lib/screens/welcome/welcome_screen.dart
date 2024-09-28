import 'package:daily_planner/route/route_constants.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/logo/logo.png', height: 150), // Thêm logo của bạn tại đây
            const SizedBox(height: 30),
            
            // Tiêu đề ứng dụng
            const Text(
              'Chào mừng đến Daily Planner!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),

            // Nút Đăng nhập
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, logInScreenRoute);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Tiếp tục'),
            ),
          ],
        ),
      ),
    );
  }
}