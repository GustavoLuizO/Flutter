import 'package:flutter/material.dart';

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