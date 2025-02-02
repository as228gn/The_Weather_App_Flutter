import 'package:flutter/material.dart';
import 'footer.dart';

class About extends StatelessWidget {
   const About({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 231, 226),
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Project Weather',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is an app that is developed for the course 1DV535 at Linneaus University using Flutter and the OpenWeatherMap API.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Developed by Anna Ståhlberg',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Footer()
        ],
      ),
    );
  }
}
