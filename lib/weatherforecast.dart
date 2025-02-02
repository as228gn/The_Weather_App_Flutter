import 'package:intl/intl.dart';

class Weatherforecast {
  final double temperature;
  final String description;
  final String icon;
  final String date;

  Weatherforecast({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.date,
  });

  factory Weatherforecast.fromJson(Map<String, dynamic> json) {
    String dateStr = json['dt_txt'];
    DateTime dateTime = DateTime.parse(dateStr);
    String formattedDate = DateFormat('EEE, MMM d, yyyy - HH:mm').format(dateTime);
    return Weatherforecast(
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      date: formattedDate,
    );
  }
}