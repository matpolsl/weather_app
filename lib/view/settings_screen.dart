import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';
import '../data/models/weather.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ustawienia"),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingsCubit, SettingsState>( // switch unit temperature 
            buildWhen: (previous, current) => previous.units != current.units,
            builder: (context, state) {
              return ListTile(
                title: const Text('Jednostka temperatury'),
                isThreeLine: true,
                subtitle: const Text(
                  'Użyj pomiarów metrycznych dla jednostek temperatury.',
                ),
                trailing: Switch(
                  value: state.units == TemperatureUnits.celsius,
                  onChanged: (_) => context.read<SettingsCubit>().toggleUnits(),
                ),
              );
            },
          ),
          BlocBuilder<SettingsCubit, SettingsState>( // switch accessibility
            buildWhen: (previous, current) =>
                previous.accessibility != current.accessibility,
            builder: (context, state) {
              return ListTile(
                title: const Text('Tryb seniora'),
                isThreeLine: true,
                subtitle: const Text(
                  'Tryb zwiększający czcionkę.',
                ),
                trailing: Switch(
                  value: state.accessibility,
                  onChanged: (_) =>
                      context.read<SettingsCubit>().toggleAccessibility(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
