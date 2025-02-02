import 'package:flutter/material.dart';
import 'about.dart';
import 'main.dart';
import 'forecast.dart';

class Footer extends StatelessWidget {
   const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrangeAccent,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowWeatherPage()),
            );
            },
           child: const Column(
              children: <Widget>[
                Icon(Icons.home),
                Text(
                  'Current',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Forecast()),
            );
            },
           child: const Column(
              children: <Widget>[
                Icon(Icons.bar_chart),
                Text(
                  'Forecast',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const About()),
            );
            },
            child: const Column(
              children: <Widget>[
                Icon(Icons.info),
                Text(
                  'About',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
