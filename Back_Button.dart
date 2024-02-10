import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: { //define second page route
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) { // most of this is just for testing and to make sure the second page is accessible
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton( // added only to navigate to second page so you can use the "back" button
          onPressed: () {
            Navigator.pushNamed(context, '/second'); // how to get to second page
          },
          child: const Text('Go to Second Page'), 
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton( // actual sign out button
          onPressed: () {
            Navigator.pop(context); // go back to home page
          },
          child: const Text('Go Back'), // would probably replace with "Sign out"
        ),
      ),
    );
  }
}
