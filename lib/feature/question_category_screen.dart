


import 'package:flutter/material.dart';
import 'package:quiz_app/feature/home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.blue, Colors.indigo],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              const Text(
                "Select Your Quiz Category",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/balloon2.png", // استبدل بالمسار الصحيح للصورة
                width: 150,
              ),
              const SizedBox(height: 40),
              _buildCategoryButton(
                context,
                title: "Sports",
                apiLink:
                    'https://opentdb.com/api.php?amount=20&category=21&type=multiple',
              ),
              const SizedBox(height: 15),
              _buildCategoryButton(
                context,
                title: "Computer Science",
                apiLink:
                    'https://opentdb.com/api.php?amount=20&category=18&type=multiple',
              ),
              const SizedBox(height: 15),
              _buildCategoryButton(
                context,
                title: "History",
                apiLink:
                    'https://opentdb.com/api.php?amount=20&category=23&type=multiple',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context,
      {required String title, required String apiLink}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(apiLink: apiLink),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 50,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
