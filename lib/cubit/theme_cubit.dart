import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../data/models/weather.dart';

class ThemeCubit extends Cubit<MaterialColor> {
  ThemeCubit() : super(defaultColor);

  static const MaterialColor defaultColor = Colors.blue;

  void updateTheme(Weather? weather) {
    if (weather != null) {
      emit(weather.toColor);
    } else {
      emit(defaultColor);
    }
  }
}

extension on Weather {
  MaterialColor get toColor {
    switch (weatherIcon) {
      case WeatherIcon.clearSkyDay:
      case WeatherIcon.clearSkyNight:
        return Colors.deepOrange;
      case WeatherIcon.snowDay:
      case WeatherIcon.snowNight:
        return Colors.lightBlue;
      case WeatherIcon.brokenCloudsDay:
      case WeatherIcon.brokenCloudsNight:
      case WeatherIcon.scatteredCloudsDay:
      case WeatherIcon.scatteredCloudsNight:
        return Colors.indigo;
      case WeatherIcon.mistDay:
      case WeatherIcon.mistNight:
        return Colors.grey;
      case WeatherIcon.rainDay:
      case WeatherIcon.showerRainDay:
      case WeatherIcon.rainNight:
      case WeatherIcon.showerRainNight:
      case WeatherIcon.thunderstormDay:
      case WeatherIcon.thunderstormNight:
        return Colors.deepPurple;
      case WeatherIcon.unknown:
      default:
        return Colors.blue;
    }
  }
}
