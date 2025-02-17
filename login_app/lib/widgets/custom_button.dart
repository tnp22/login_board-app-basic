import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;  //버튼 텍스트
  final VoidCallback onPressed; // 버튼 클릭 콜백
  final isFullWidth;  // 가로 전체 여부
  final color;        // 글씨 색상
  final backgroundColor;  // 배경 색상

  const Custombutton({
      super.key,
      required this.text,
      required this.onPressed,
      this.isFullWidth,
      this.color = Colors.white,
      this.backgroundColor = Colors.blueAccent
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth == true? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: const TextStyle(fontSize:16),
        ),
        child: Text(text),
        )
    );
  }
}