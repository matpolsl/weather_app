import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'clock_widget.dart';
import 'sun_time_widget.dart';
import '../../cubit/settings_cubit.dart';
import 'weather_icon.dart';
import '../../data/models/weather.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  const WeatherWidget(this.weather, this.onRefresh, {Key? key})
      : super(key: key);
  final ValueGetter<Future<void>> onRefresh;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _WeatherBackground(),
        RefreshIndicator(
          onRefresh: onRefresh,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  weather.city,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const Center(child: ClockWidget()),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WeatherIconWidget(weather.weatherIcon),
                      Column(
                        children: [
                          BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, state) {
                              return Text(
                                weather.getTemperatureText(state.units),
                                style: Theme.of(context).textTheme.headline4,
                              );
                            },
                          ),
                          Text(
                            'Ciśnienie ${weather.pressure.toString()} hPa',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  weather.description,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    'Aktualiazcja: ${DateFormat.Hm().format(weather.updateTime)}',
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SunTimeWidget(
                    weather, Theme.of(context).primaryColorDark.brighten(20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor.brighten(35);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            color,
            color.brighten(10),
            color.brighten(33),
            color.brighten(50),
          ],
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
