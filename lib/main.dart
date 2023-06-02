import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MyApp(),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Icon> score= [ ];

  void checkAns (bool userAns){
    bool correctAns = quizBrain.getCorrectAns();

    setState(() {
      if (quizBrain.isFinished() == true) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Finished!'),
              content: const Text(
                  'You\'ve reached the end of the quiz.',
              style: TextStyle(
                fontSize: 18.0,

              ),),
              actions:[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(14),
                    child: const Text(
                        "Restart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        );

        quizBrain.reset();

        score = [ ];
      }

      else {
      if (userAns == correctAns){
        score.add(const Icon(
          Icons.check,
          color: Colors.green,
        ),);
      }
      else {
        score.add(const Icon(
          Icons.close,
          color: Colors.red,
        ),);
      }

      quizBrain.nextQ();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
                onPressed: (){
                  checkAns(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: const Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: (){
                  checkAns(false);
                },
              ),
            ),
          ),

          Row(
            children:  score,
          ),

        ]
    );
  }
}

