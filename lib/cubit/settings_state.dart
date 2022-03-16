part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState(this.units, this.accessibility);
  final TemperatureUnits units;
  final bool accessibility;
  @override
  List<Object> get props => [units, accessibility];
}
