import 'package:json_annotation/json_annotation.dart';

part 'survey_point.g.dart';

@JsonSerializable()
class SurveyPoint {
  final double latitude;
  final double longitude;
  final double lightIntensity; // lux
  final double activityLevel; // magnitude of accelerometer
  final double magneticField; // magnitude of magnetometer
  final DateTime timestamp;

  const SurveyPoint({
    required this.latitude,
    required this.longitude,
    required this.lightIntensity,
    required this.activityLevel,
    required this.magneticField,
    required this.timestamp,
  });

  factory SurveyPoint.fromJson(Map<String, dynamic> json) =>
      _$SurveyPointFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyPointToJson(this);

  @override
  String toString() {
    return 'SurveyPoint(lat: $latitude, lng: $longitude, light: ${lightIntensity.toStringAsFixed(1)}lux, activity: ${activityLevel.toStringAsFixed(2)}, magnetic: ${magneticField.toStringAsFixed(1)}μT, time: $timestamp)';
  }
}
