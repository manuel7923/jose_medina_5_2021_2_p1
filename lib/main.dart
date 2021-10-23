import 'package:flutter/material.dart';
import 'package:rycky_and_morty_app/screens/characters_screen.dart';
import 'package:rycky_and_morty_app/screens/wait_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ricky and Morty',
      home: _isLoading 
        ? WaitScreen() 
        : CharactersScreen(),
    );
  }
}