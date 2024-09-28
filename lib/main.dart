import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:daily_planner/route/route_constants.dart';
import 'package:daily_planner/route/router.dart' as router;
import 'package:daily_planner/theme/app_theme.dart';
import 'package:daily_planner/screens/task/components/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()), // TaskProvider để quản lý công việc
        // Thêm các provider khác nếu cần
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Planner',
        theme: AppTheme.lightTheme(context),  // Sử dụng theme từ AppTheme
        themeMode: ThemeMode.light,
        onGenerateRoute: router.generateRoute,  // Sử dụng router để điều hướng
        initialRoute: welcomeScreenRoute,  // Màn hình ban đầu là welcomeScreen
      ),
    );
  }
}
