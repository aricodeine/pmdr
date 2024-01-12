// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimerProfile _$TimerProfileFromJson(Map<String, dynamic> json) => TimerProfile(
      profileName: json['profileName'] as String,
      numberOfMins: json['numberOfMins'] as int,
    );

Map<String, dynamic> _$TimerProfileToJson(TimerProfile instance) =>
    <String, dynamic>{
      'profileName': instance.profileName,
      'numberOfMins': instance.numberOfMins,
    };
