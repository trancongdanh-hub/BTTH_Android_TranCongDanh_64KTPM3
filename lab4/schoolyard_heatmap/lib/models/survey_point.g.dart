// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyPoint _$SurveyPointFromJson(Map<String, dynamic> json) => SurveyPoint(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  lightIntensity: (json['lightIntensity'] as num).toDouble(),
  activityLevel: (json['activityLevel'] as num).toDouble(),
  magneticField: (json['magneticField'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$SurveyPointToJson(SurveyPoint instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'lightIntensity': instance.lightIntensity,
      'activityLevel': instance.activityLevel,
      'magneticField': instance.magneticField,
      'timestamp': instance.timestamp.toIso8601String(),
    };
