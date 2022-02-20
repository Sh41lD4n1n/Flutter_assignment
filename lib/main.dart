import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(const MyApp());

/*class OneJoke extends Padding {
  OneJoke({required EdgeInsetsGeometry padding}) : super(padding: padding);
  
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Jokes about Chuck Norris'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: const [
                //Image(
                //  image: Image.file('./random-grid.jpg'),
                //),
                Text("s"),
                Text("Here is short joke")
              ])),
    ));
  }
}
