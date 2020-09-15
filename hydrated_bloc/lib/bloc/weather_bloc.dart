import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    final weather = Weather.fromMap(json);
    return WeatherLoaded(weather);
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    if (state is WeatherLoaded) {
      return state.weather.toMap();
    } else {
      return null;
    }
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      // Outputting a state from the asynchronous generator
      yield WeatherLoading();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
        );
      },
    );
  }
}
