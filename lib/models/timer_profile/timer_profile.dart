import 'package:json_annotation/json_annotation.dart';

part 'timer_profile.g.dart';

@JsonSerializable()
class TimerProfile {
  final String profileName;
  final int numberOfMins;

  const TimerProfile({required this.profileName, required this.numberOfMins});

  factory TimerProfile.fromJson(Map<String, dynamic> json) =>
      _$TimerProfileFromJson(json);

  Map<String, dynamic> toJson() => _$TimerProfileToJson(this);
}
