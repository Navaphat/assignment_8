import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            border: Border.all(width: 10.0, color: Colors.green),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(10.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: 0.5,
              ),
            ],
          ),
          //alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/guess_logo.png',
                        height: 150.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Text('GUESS', style: TextStyle(fontSize: 50.0, color: Colors.red.shade100), ),
                            Text('THE NUMBER', style: TextStyle(fontSize: 25.0, color: Colors.red), ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: TextField(),
                  height: 75.0,
                  width: 350,
                ),
                SizedBox(
                  height: 50.0,
                  width: 120.0,
                  child: ElevatedButton(
                    child: Text(
                      'Guess',
                      style: TextStyle(fontSize: 25.0, color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
