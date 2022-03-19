import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/settings_cubit.dart';

import '../../data/models/weather.dart';

class WeatherIconWidget extends StatelessWidget {
  final WeatherIcon icon;
  const WeatherIconWidget(this.icon, {Key? key}) : super(key: key);
  static String _mapWeatherIcontoString(WeatherIcon icon) {
    Map<WeatherIcon, String> map = {
      WeatherIcon.clearSkyDay: 'images/weather_icons/clearSkyDay.png',
      WeatherIcon.fewCloudsDay: 'images/weather_icons/fewCloudsDay.png',
      WeatherIcon.scatteredCloudsDay:
          'images/weather_icons/scatteredCloudsDay.png',
      WeatherIcon.brokenCloudsDay:
          'images/weather_icons/scatteredCloudsDay.png',
      WeatherIcon.showerRainDay: 'images/weather_icons/rainDay.png',
      WeatherIcon.rainDay: 'images/weather_icons/rainDay.png',
      WeatherIcon.thunderstormDay: 'images/weather_icons/thunderstormDay.png',
      WeatherIcon.snowDay: 'images/weather_icons/snowDay.png',
      WeatherIcon.mistDay: 'images/weather_icons/mistDay.png',
      WeatherIcon.clearSkyNight: 'images/weather_icons/clearSkyNight.png',
      WeatherIcon.fewCloudsNight: 'images/weather_icons/fewCloudsNight.png',
      WeatherIcon.scatteredCloudsNight:
          'images/weather_icons/scatteredCloudsNight.png',
      WeatherIcon.brokenCloudsNight:
          'images/weather_icons/scatteredCloudsNight.png',
      WeatherIcon.showerRainNight: 'images/weather_icons/rainNight.png',
      WeatherIcon.rainNight: 'images/weather_icons/rainNight.png',
      WeatherIcon.thunderstormNight:
          'images/weather_icons/thunderstormNight.png',
      WeatherIcon.snowNight: 'images/weather_icons/snowNight.png',
      WeatherIcon.mistNight: 'images/weather_icons/mistNight.png',
    };
    return map[icon] ?? ' ';
  }

  @override
  Widget build(BuildContext context) {
    final accessibility =
        BlocProvider.of<SettingsCubit>(context).state.accessibility;
    return accessibility
        ? Image.asset(
            _mapWeatherIcontoString(icon),
            scale: 0.7,
          )
        : Image.asset(
            _mapWeatherIcontoString(icon),
          );
  }
}
