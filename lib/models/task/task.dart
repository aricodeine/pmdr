import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'task.g.dart';

@Entity()
@JsonSerializable()
class Task {
  @Id()
  int id;
  String taskName;
  bool isCompleted;

  Task({this.id = 0, required this.taskName, this.isCompleted = false});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
