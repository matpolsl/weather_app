import 'package:http/http.dart' as http;

import '../models/weather.dart';
import 'app_exception.dart';

const baseurl = 'https://api.openweathermap.org';
weatherUrl(city) =>
    '$baseurl/data/2.5/weather?q=$city&APPID=b31c2399a91bd7f2a5019bbe3fa1e049&lang=pl';

class WeatherRepository {
  final http.Client httpClient;
  WeatherRepository(this.httpClient);
  Future<Weather> fetchWeatherFromCity(String city) async {
    try {
      final response = await httpClient.get(Uri.parse(weatherUrl(city)));
      switch (response.statusCode) {
        case 200:
          return Weather.fromJson(response.body);
        case 400:
          throw FetchDataException("Nie wprowadzono miasta");
        case 401:
        case 403:
          throw FetchDataException(response.body.toString());
        case 404:
          throw FetchDataException("Nie znaleziono pogody dla miasta: $city");
        case 500:
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {
      throw FetchDataException("Błąd połączenia z internetem");
    }
  }
}
