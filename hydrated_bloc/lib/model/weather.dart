import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;

  Weather({
    @required this.cityName,
    @required this.temperature,
  });

  @override
  List<Object> get props => [cityName, temperature];

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temperature': temperature,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Weather(
      cityName: map['cityName'] as String,
      temperature: (map['temperature'] as num)?.toDouble(),
    );
  }
}
