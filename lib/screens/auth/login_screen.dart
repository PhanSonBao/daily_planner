import 'package:daily_planner/route/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = ''; // Biến để lưu trữ thông điệp lỗi

  // Đăng ký tài khoản với Firebase
  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      debugPrint('Registered user: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      debugPrint('Đăng ký thất bại: ${e.message}');
    }
  }

  // Đăng nhập tài khoản với Firebase
  Future<void> _signIn() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      debugPrint('Signed in: ${userCredential.user?.email}');
      if(mounted) {
        Navigator.pushNamed(context, homePageScreenRoute);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Đăng nhập thất bại: ${e.message}');
      setState(() {
        _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Password TextField
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Nút Đăng nhập
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Đăng nhập'),
            ),

            // Nút Đăng ký
            TextButton(
              onPressed: _register,
              child: const Text('Đăng ký tài khoản mới'),
            ),

            if(_errorMessage.isNotEmpty)
              Text(_errorMessage, style: const TextStyle(color: Colors.red),),
          ],
        ),
      ),
    );
  }
}
