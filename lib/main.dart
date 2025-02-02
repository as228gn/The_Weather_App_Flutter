import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';
import 'footer.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Weather App',
    home: ShowWeatherPage(),
  ));
}

class ShowWeatherPage extends StatefulWidget {
  const ShowWeatherPage({super.key});

  @override
  State<ShowWeatherPage> createState() => _ShowWeatherPageState();
}

class _ShowWeatherPageState extends State<ShowWeatherPage> {
  double? _latitude;
  double? _longitude;
  Weather? fetchedWeather;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _fetchWeather(_latitude, _longitude);
      });
    } else {
      throw Exception('No location');
    }
  }

  Future<void> _fetchWeather(latitude, longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=7a65c63e2de8469a8caf858223e2a551&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        fetchedWeather = Weather.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, MMM d, yyyy').format(now);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 231, 226),
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: fetchedWeather != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          "https://openweathermap.org/img/wn/${fetchedWeather!.icon}@2x.png"),
                      Text(
                        '${fetchedWeather!.location}, ${fetchedWeather!.country}',
                        style: const TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        fetchedWeather!.description,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${fetchedWeather!.temp.round()}°C',
                        style: const TextStyle(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Footer(),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            ),
    );
  }
}
