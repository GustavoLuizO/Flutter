import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget(title: 'Title by param',));
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()

      // home: const Center(    
      //   child: Text(
      //     'Fluterando',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageStates();
  }
}

class HomePageStates extends State<HomePage> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text(
          'HomePage full state | counter: $counter',
        ),
        onTap:() => setState(() {
          counter++;
        })
      ),
    );
  }
}