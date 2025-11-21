import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color textColor;
  final double textSize;
  final Function(String) callback;

  const CalculatorButton({
    super.key,
    required this.text,
    this.fillColor = const Color(0xFF2E3131),
    this.textColor = Colors.white,
    this.textSize = 24.0,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    // GHI CHÚ QUAN TRỌNG: Sử dụng AspectRatio và CircleBorder để tạo nút hình tròn 
    // và đảm bảo nó luôn là hình vuông trong Row (khớp với hình ảnh).
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Khoảng cách giữa các nút (tổng 16px)
        child: AspectRatio(
          aspectRatio: 1.0, // Tỷ lệ 1:1 (Hình vuông)
          child: TextButton(
            onPressed: () => callback(text), // Gọi hàm xử lý logic khi nhấn
            style: TextButton.styleFrom(
              backgroundColor: fillColor,
              shape: const CircleBorder(), // TẠO HÌNH TRÒN
              padding: const EdgeInsets.all(16.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}