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
     String titlePage = 'Home page';

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
      ),
      
      body: Center(
        child: GestureDetector(
          child: Text(
            'Counter: $counter',
            style: const TextStyle(
              fontSize: 20
            ),
          ),
          onTap:() => setState(() {
            counter++;
          })
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add
        ),
        onPressed: () => setState(() {
          counter--;
        })
      ),
    );
  }
}