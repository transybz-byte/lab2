import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculator_screen.dart'; // Import màn hình máy tính

void main() {
  // Đảm bảo chỉ chạy ở chế độ dọc
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  // Hằng số Màu sắc từ Figma
  static const Color primaryColor = Color(0xFF2D3142);
  static const Color secondaryColor = Color(0xFF4F5D75);
  static const Color accentColor = Color(0xFFEF8354);
  static const Color lightColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48, // Kết quả
            fontWeight: FontWeight.w500,
            color: lightColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 24, // Nút
            fontWeight: FontWeight.w400,
            color: lightColor,
          ),
          titleMedium: TextStyle(
            fontSize: 18, // Phương trình nhỏ
            fontWeight: FontWeight.w400,
            color: lightColor,
          ),
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}
