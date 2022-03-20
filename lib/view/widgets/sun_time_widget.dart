import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/weather.dart';

class SunTimeWidget extends StatelessWidget {
  final Weather weather;
  final Color color;
  const SunTimeWidget(this.weather, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "🌄",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "Wschód: ${DateFormat.Hm().format(weather.sunrise)}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "🌇",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "Zachód: ${DateFormat.Hm().format(weather.sunset)}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
