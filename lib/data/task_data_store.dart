import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class TaskDataStore {
  static const boxName = "tasks";
  final Box<Task> box = Hive.box<Task>(boxName);

  /// Add new Task
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  /// Show Task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Get Task Count
  int getTaskCount() {
    return box.length;
  }

  /// Get Task Count by TaskListId
  int getTaskCountByTaskListId(String taskListId) {
    return box.values.where((task) => task.taskListId == taskListId).length;
  }

  /// Update Task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  /// Delete Task
  Future<void> deleteTask({required String id}) async {
    await box.delete(id);
  }

  /// Get all tasks
  List<Task> getAllTasks() {
    return box.values.toList();
  }

  ValueListenable<Box<Task>> listenToTasks() {
    return box.listenable();
  }
}
