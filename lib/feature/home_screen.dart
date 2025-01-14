
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/core/api_services.dart';
// import 'package:quiz_app/core/colors.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future quiz;
//   int seconds = 60;
//   int currentIndexOfQuestion = 0;
//   Timer? timer;
//   bool isLoading = false;
//   var optionList = [];
//   var optionColor = [
//     Colors.white,
//     Colors.white,
//     Colors.white,
//     Colors.white,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     quiz = getQuizData();
//     startTimer();
//   }

//   void resetColor() {
//     optionColor = [
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//     ];
//   }
   
   

//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) return;
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//         } else {
//           gotoNextQuestion();
//         }
//       });
//     });
//   }

//   void gotoNextQuestion() {
//     if (currentIndexOfQuestion < 19) {
//       setState(() {
//         isLoading = false;
//         resetColor();
//         currentIndexOfQuestion++;
//         seconds = 60;
//       });
//     } else {
//       timer?.cancel();
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Quiz Completed"),
//           content: const Text("You have completed all 20 questions."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         padding: const EdgeInsets.all(15),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             colors: [
//               Colors.blue,
//               blue,
//               darkBule,
//             ],
//           ),
//         ),
//         child: FutureBuilder(
//           future: quiz,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(Colors.white),
//               ));
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Error: ${snapshot.error}",
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//                 ),
//               );
//             }
//            else if (snapshot.hasData) {
//               var data = snapshot.data["results"];
//               if (!isLoading) {
//                 optionList = data[currentIndexOfQuestion]['incorrect_answers'];
//                 optionList.add(data[currentIndexOfQuestion]['correct_answer']);
//                 optionList.shuffle();
//                 isLoading = true;
//               }
//               return SafeArea(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border.all(color: Colors.red, width: 1),
//                             ),
//                             child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(
//                                 Icons.close,
//                                 color: Colors.red,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Text(
//                                 "$seconds",
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 70,
//                                 width: 70,
//                                 child: CircularProgressIndicator(
//                                   value: seconds / 60,
//                                   valueColor: const AlwaysStoppedAnimation(
//                                       Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Image.asset(
//                         "assets/images/ideas.png",
//                         width: 180,
//                       ),
//                       const SizedBox(height: 20),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Question ${currentIndexOfQuestion + 1} of 20",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         data[currentIndexOfQuestion]['question'],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: optionList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           var correctAnswer =
//                               data[currentIndexOfQuestion]['correct_answer'];
//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 if (correctAnswer.toString() ==
//                                     optionList[index].toString()) {
//                                   optionColor[index] = Colors.green;
//                                 } else {
//                                   optionColor[index] = Colors.red;
//                                 }
//                                 Future.delayed(
//                                   const Duration(seconds: 1),
//                                   () => gotoNextQuestion(),
//                                 );
//                               });
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(bottom: 20),
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width - 100,
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                 color: optionColor[index],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 optionList[index].toString(),
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return const Center(
//                 child: Text("No Data Found"),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/core/api_services.dart';
import 'package:quiz_app/core/colors.dart';
import 'result_screen.dart'; // استيراد شاشة النتائج

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future quiz;
  int seconds = 60;
  int currentIndexOfQuestion = 0;
  int correctAnswers = 0; // عدد الإجابات الصحيحة
  int wrongAnswers = 0; // عدد الإجابات الخاطئة
  Timer? timer;
  bool isLoading = false;
  var optionList = [];
  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuizData();
    startTimer();
  }

  void resetColor() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  void gotoNextQuestion() {
    if (currentIndexOfQuestion < 19) {
      setState(() {
        isLoading = false;
        resetColor();
        currentIndexOfQuestion++;
        seconds = 60;
      });
    } else {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            correctAnswers: correctAnswers,
            wrongAnswers: wrongAnswers,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue,
              blue,
              darkBule,
            ],
          ),
        ),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data["results"];
              if (!isLoading) {
                optionList = data[currentIndexOfQuestion]['incorrect_answers'];
                optionList.add(data[currentIndexOfQuestion]['correct_answer']);
                optionList.shuffle();
                isLoading = true;
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor:
                                      const AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/images/ideas.png",
                        width: 180,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Question ${currentIndexOfQuestion + 1} of 20",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data[currentIndexOfQuestion]['question'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var correctAnswer =
                              data[currentIndexOfQuestion]['correct_answer'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (correctAnswer.toString() ==
                                    optionList[index].toString()) {
                                  optionColor[index] = Colors.green;
                                  correctAnswers++; // زيادة عدد الإجابات الصحيحة
                                } else {
                                  optionColor[index] = Colors.red;
                                  wrongAnswers++; // زيادة عدد الإجابات الخاطئة
                                }
                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () => gotoNextQuestion(),
                                );
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: optionColor[index],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                optionList[index].toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("No Data Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
