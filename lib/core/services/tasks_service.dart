import 'package:flutter/material.dart' show debugPrint;
import 'package:path_provider/path_provider.dart';
import 'package:pmdr/models/task/task.dart';
import 'package:path/path.dart' as p;
import 'package:pmdr/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store _store;
  late final Box<Task> _taskBox;

  ObjectBox._create(this._store) {
    _taskBox = Box<Task>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }

  Stream<List<Task>> getTasks() {
    final qBuilderTasks = _taskBox.query().order(Task_.id, flags: Order.descending);
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return qBuilderTasks
        .watch(triggerImmediately: true)
        // Map it to a list of tasks to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Task getTask(int id) => _taskBox.get(id)!;

  Future<void> removeTask(int taskId) async => await _taskBox.removeAsync(taskId);

  Future<void> saveTask(Task task) async {
    await _taskBox.putAsync(task);
    // _taskBox.removeAll();
    debugPrint('Saved task ${task.taskName}');
  }

  Future<void> finishTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _taskBox.putAsync(task);
  }
}
