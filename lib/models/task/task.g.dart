// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      taskName: json['taskName'] as String,
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskName': instance.taskName,
      'isCompleted': instance.isCompleted,
    };
