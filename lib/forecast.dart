import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weatherforecast.dart';
import 'footer.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  double? _latitude;
  double? _longitude;
  List<Weatherforecast>? fetchedWeather;

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

  Future<void> _fetchWeather(double? latitude, double? longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=7a65c63e2de8469a8caf858223e2a551&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body)['list'];
      setState(() {
        fetchedWeather = list
            .map((json) => Weatherforecast.fromJson(json))
            .toList();
      });
    } else {
      throw Exception('Failed to load JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Scrollbar(
                    thickness: 9.0,
                    radius: const Radius.circular(10.0),
                    child: ListView.builder(
                      itemCount: fetchedWeather!.length,
                      itemBuilder: (context, index) {
                        final weather = fetchedWeather![index];
                        return ListTile(
                          title: Text('${weather.temperature.round()} °C'),
                          subtitle: Text(weather.description),
                          leading: Image.network(
                              'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                          trailing: Text(weather.date),
                        );
                      },
                    ),
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