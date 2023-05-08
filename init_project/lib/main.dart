import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget(title: 'Title by param',));
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: const Center(    
        child: Text(
          'Fluterando',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}