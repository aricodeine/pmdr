import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String taskName;
  final bool? isCompleted;

  const Task({required this.taskName, this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
