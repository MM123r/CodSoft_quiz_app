import 'package:flutter/material.dart';
import 'package:quiz_app/core/colors.dart';
import 'package:quiz_app/core/navigation.dart';
import 'package:quiz_app/feature/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.lightBlue,
            blue,
            darkBule,
          ])),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset("assets/images/balloon2.png"),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Welcome to our ",
            style: TextStyle(color: lightgrey, fontSize: 18),
          ),
          const Text(
            "Quiz App",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                pushTO(context, const HomeScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 25,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 100,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    ));
  }
}
