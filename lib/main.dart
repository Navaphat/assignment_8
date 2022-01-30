import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess_Number',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static const buttonSize = 75.0;
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  var game = Game();
  String alertMessage = '';

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
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(10.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      Image.asset('assets/images/guess_logo.png', width: 125),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('GUESS', style: TextStyle(fontSize: 50.0, color: Colors.red.shade100)),
                            Text('THE NUMBER', style: TextStyle(fontSize: 25.0, color: Colors.red),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_input, style: TextStyle(fontSize: 50.0),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alertMessage, style: TextStyle(fontSize: 20.0),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i = 1; i <= 3; i++) buildButton(num: i),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i = 4; i <= 6; i++) buildButton(num: i),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(var i = 7; i <= 9; i++) buildButton(num: i),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(num: -2),
                  buildButton(num: 0),
                  buildButton(num: -1),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 32.0),
                child: SizedBox(
                  height: 50.0,
                  width: 120.0,
                  child: ElevatedButton(
                    child: Text('Guess', style: TextStyle(fontSize: 25.0, color: Colors.black)),
                    onPressed: () {
                      var guess = int.tryParse(_input!);

                      int result = game.doGuess(guess!);
                      setState(() {
                        if (result == 1) {
                          alertMessage = '$guess is TOO HIGH!, Please try again.';
                        } else if (result == -1) {
                          alertMessage = '$guess is TOO LOW!, Please try again.';
                        } else {
                          alertMessage = '$guess is CORRECT, total guesses: ${game.getCount}';
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  String _input = '';
  Widget buildButton({int? num}) {
    Widget? child;
    BoxDecoration? boxDecoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: 2.0,),
    );

    if(num == -1)
      child = Icon(Icons.backspace_outlined, size: 30.0,);
    else if(num == -2) {
      child = Text('X', style: TextStyle(fontSize: 25.0),);
    }
    else{
      child = Text('${num}', style: TextStyle(fontSize: 25.0),);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            if(num == -1)
              _input = _input.substring(0,_input.length-1);
            else if(num != -2 && _input.length < 3)
              _input += "$num";
            else if(num == -2)
              _input = '';
          });
        },
        borderRadius: BorderRadius.circular(37.5),
        child: Container(
          width: HomePage.buttonSize,
          height: HomePage.buttonSize,
          decoration: boxDecoration,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
