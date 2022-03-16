import 'package:http/http.dart' as http;

import '../models/weather.dart';

const baseurl = 'https://api.openweathermap.org';
weatherUrl(city) =>
    '$baseurl/data/2.5/weather?q=$city&APPID=b31c2399a91bd7f2a5019bbe3fa1e049&lang=pl';

class WeatherRepository {
  final http.Client httpClient;
  WeatherRepository(this.httpClient);
  Future<Weather> fetchWeatherFromCity(String city) async {
    final response = await httpClient.get(Uri.parse(weatherUrl(city)));
    if (response.statusCode == 200) {
      return Weather.fromJson(response.body);
    } else {
      throw Exception("Error getting weather of location: $city");
    }
  }
}
