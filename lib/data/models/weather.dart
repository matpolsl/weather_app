import 'dart:convert';

enum WeatherIcon {
  clearSkyDay,
  fewCloudsDay,
  scatteredCloudsDay,
  brokenCloudsDay,
  showerRainDay,
  rainDay,
  thunderstormDay,
  snowDay,
  mistDay,
  clearSkyNight,
  fewCloudsNight,
  scatteredCloudsNight,
  brokenCloudsNight,
  showerRainNight,
  rainNight,
  thunderstormNight,
  snowNight,
  mistNight,
  unknown
}

enum TemperatureUnits { fahrenheit, celsius }

class Weather {
  final double temp;
  final String city;
  final int pressure;
  final String description;
  final WeatherIcon weatherIcon;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime updateTime;
  Weather({
    required this.temp,
    required this.city,
    required this.pressure,
    required this.description,
    required this.weatherIcon,
    required this.sunrise,
    required this.sunset,
    required this.updateTime,
  });

  Weather copyWith({
    double? temp,
    String? city,
    int? pressure,
    String? description,
    WeatherIcon? weatherIcon,
    DateTime? sunrise,
    DateTime? sunset,
    DateTime? updateTime,
  }) {
    return Weather(
      temp: temp ?? this.temp,
      city: city ?? this.city,
      pressure: pressure ?? this.pressure,
      description: description ?? this.description,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  String getTemperatureText(unit) {
    if (unit == TemperatureUnits.celsius) {
      return '${(temp - 273.15).toStringAsFixed(0)} °C';
    } else {
      return '${((temp - 273.15) * 1.8000 + 32.00).toStringAsFixed(0)} °F';
    }
  }

  static WeatherIcon _mapStringToWeatherIcon(String inputString) {
    Map<String, WeatherIcon> map = {
      '01d': WeatherIcon.clearSkyDay,
      '02d': WeatherIcon.fewCloudsDay,
      '03d': WeatherIcon.scatteredCloudsDay,
      '04d': WeatherIcon.brokenCloudsDay,
      '09d': WeatherIcon.showerRainDay,
      '10d': WeatherIcon.rainDay,
      '11d': WeatherIcon.thunderstormDay,
      '13d': WeatherIcon.snowDay,
      '50d': WeatherIcon.mistDay,
      '01n': WeatherIcon.clearSkyNight,
      '02n': WeatherIcon.fewCloudsNight,
      '03n': WeatherIcon.scatteredCloudsNight,
      '04n': WeatherIcon.brokenCloudsNight,
      '09n': WeatherIcon.showerRainNight,
      '10n': WeatherIcon.rainNight,
      '11n': WeatherIcon.thunderstormNight,
      '13n': WeatherIcon.snowNight,
      '50n': WeatherIcon.mistNight,
    };
    return map[inputString] ?? WeatherIcon.unknown;
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'city': city,
      'pressure': pressure,
      'description': description,
      'weatherIcon': weatherIcon,
      'sunrise': sunrise.millisecondsSinceEpoch,
      'sunset': sunset.millisecondsSinceEpoch,
      'updateTime': updateTime.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
        temp: map['main']['temp']?.toDouble() ?? 0.0,
        city: map['name'] ?? '',
        pressure: map['main']['pressure']?.toInt() ?? 0,
        description: map['weather'][0]['description'] ?? '',
        weatherIcon: _mapStringToWeatherIcon(map['weather'][0]['icon']),
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(map['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(map['sys']['sunset'] * 1000),
        updateTime: DateTime.now());
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Weather(temp: $temp, city: $city, pressure: $pressure, description: $description, weatherIcon: $weatherIcon, sunrise: $sunrise, sunset: $sunset, updateTime: $updateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.temp == temp &&
        other.city == city &&
        other.pressure == pressure &&
        other.description == description &&
        other.weatherIcon == weatherIcon &&
        other.sunrise == sunrise &&
        other.sunset == sunset &&
        other.updateTime == updateTime;
  }

  @override
  int get hashCode {
    return temp.hashCode ^
        city.hashCode ^
        pressure.hashCode ^
        description.hashCode ^
        weatherIcon.hashCode ^
        sunrise.hashCode ^
        sunset.hashCode ^
        updateTime.hashCode;
  }
}
