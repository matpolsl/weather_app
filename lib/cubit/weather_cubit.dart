import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/weather.dart';
import '../data/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeatherFromCity(cityName);
      //print(weather.description.toString());
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> refreshWeather(String cityName) async {
    try {
      //emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeatherFromCity(cityName);
      //print(weather.description.toString());
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  void setInitialState() {
    emit(const WeatherInitial());
  }
}
