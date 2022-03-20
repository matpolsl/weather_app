import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/models/weather.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(TemperatureUnits.celsius, false));

  toggleUnits() {
    late final TemperatureUnits units;
    if (state.units != TemperatureUnits.celsius) {
      units = TemperatureUnits.celsius;
    } else {
      units = TemperatureUnits.fahrenheit;
    }
    emit(SettingsState(units, state.accessibility));
  }

  toggleAccessibility() {
    late final bool accessibility;
    if (state.accessibility) {
      accessibility = false;
    } else {
      accessibility = true;
    }
    emit(SettingsState(state.units, accessibility));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    if (json['TemperatureUnits']) {
      return SettingsState(
          TemperatureUnits.celsius, json['accessibility'] as bool);
    } else {
      return SettingsState(
          TemperatureUnits.fahrenheit, json['accessibility'] as bool);
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    if (state.units == TemperatureUnits.celsius) {
      return {'TemperatureUnits': true, 'accessibility': state.accessibility};
    } else {
      return {'TemperatureUnits': false, 'accessibility': state.accessibility};
    }
  }
}
