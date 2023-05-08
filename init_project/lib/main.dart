import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget(title: 'Title by param',));
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.yellow,
          fontSize: 50
        ),
      ),
    );
  }
}