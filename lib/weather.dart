class Weather {
  final double temp;
  final String description;
  final String icon;
  final String country;
  final String location;

  Weather({
    required this.temp,
    required this.description,
    required this.icon,
    required this.country,
    required this.location,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      country: json['sys']['country'],
      location: json['name'],
    );
  }
}