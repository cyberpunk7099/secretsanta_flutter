import 'package:customizable_flashcard/customizable_flashcard.dart';
import 'package:customizable_flashcard/flashcard_side_enum.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 100;
  bool removingCard = false;
  bool absorb = false;
  List<String> names = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Frank',
    'Grace',
    'Hank',
    'Ivy',
    'Jack',
    'chetan',
    'sami',
    'tami',
    'puru'
  ];
  @override
  Widget build(BuildContext context) {
    // names.shuffle();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          if (currentIndex != 100 && !removingCard) {
            print(names.length);
            setState(() {
              removingCard = true;
            });
            await Future.delayed(Duration(seconds: 5));
            setState(() {
              names.removeAt(currentIndex!);
            });
            setState(() {
              names.shuffle();
            });
            setState(() {
              removingCard = false;
            });
            currentIndex = 100;
            print(names.length);
          } else {
            print('sadfasd asdfasdf asdf');
            Fluttertoast.showToast(
                msg:
                    'Please Flip a card and if it is loading wait till loading finish.',
                toastLength: Toast.LENGTH_LONG);
          }
        },
        child: Icon(
          Icons.shuffle_rounded,
          color: Colors.white,
        ),
      ),
      body: removingCard
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Wait Rearranging Flashcards....'),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(),
              ],
            ))
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Wrap(
                  children: List.generate(names.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.white,
                        ),
                        child: AbsorbPointer(
                          absorbing:
                              index == currentIndex || currentIndex == 100
                                  ? false
                                  : true,
                          child: FlashCard(
                            defaultSide: FlashCardSide.front,
                            ontap: () async {
                              setState(() {
                                currentIndex = index;
                              });
                              print('current index $currentIndex');
                            },
                            onFlip: (newSide) {},
                            frontWidget: Container(
                              // child: Center(
                              //   child: Text(
                              //     names[index],
                              //     style: TextStyle(
                              //       fontSize: 24,
                              //       fontWeight: FontWeight.w700,
                              //     ),
                              //   ),
                              // ),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://media.istockphoto.com/id/1357890892/vector/cute-santa-claus-with-christmas-present-vector-illustration.jpg?s=612x612&w=0&k=20&c=yxVfubuudRYEX5KB5agDTIC9epNBNz0VzA3Z__aZFQU='),
                                ),
                              ),
                            ),
                            backWidget: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    names[index],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Center(
                                    child: Lottie.asset(
                                  'load.json',
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ))
                              ],
                            ),
                            frontGradient: const LinearGradient(
                              colors: [Colors.white, Colors.white],
                            ),
                            backGradient: const LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.white,
                                Colors.white,
                                Colors.blue
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
