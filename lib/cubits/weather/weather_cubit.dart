import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_cubit_listener/models/custom_error.dart';
import 'package:open_weather_cubit_listener/models/weather.dart';
import 'package:open_weather_cubit_listener/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
      debugPrint('state: $state');
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
      debugPrint('state: $state');
    }
  }
}
