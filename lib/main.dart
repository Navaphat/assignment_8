import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  var game = Game();

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(),
                      hintText: 'Guess the Number 1 to ${game.getMaxRandom}',
                    ),
                  ),
                  height: 75.0,
                  width: 350,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 120.0,
                    child: ElevatedButton(
                      child: Text('Guess', style: TextStyle(fontSize: 25.0, color: Colors.black)),
                      onPressed: () {
                        var input = _controller.text;
                        var guess = int.tryParse(input);
                        String titleResult = 'Result';
                        String titleError = 'Error';
                        String errorMessage = 'Wrong input, Please enter number only.';

                        if(guess == null){
                          showDialog(context: context, barrierDismissible: false, builder: (BuildContext context, ) {
                            return AlertDialog(
                              title: Text(titleError),
                              content: Text(errorMessage),

                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok')
                                ),
                              ],
                            );
                          });
                        }

                        int result = game.doGuess(guess!);
                        String resultMessage;
                        if (result == 1) {
                          resultMessage = '$guess is TOO HIGH!, Please try again.';
                        } else if (result == -1) {
                          resultMessage = '$guess is TOO LOW!, Please try again.';
                        } else {
                          resultMessage = '$guess is CORRECT, total guesses: ${game.getCount}';
                        }

                        showDialog(context: context, barrierDismissible: false, builder: (BuildContext context, ) {
                          return AlertDialog(
                            title: Text(titleResult),
                            content: Text(resultMessage),

                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    },
                                  child: Text('Ok')
                              ),
                            ],
                          );
                        });
                      },
                    ),
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
