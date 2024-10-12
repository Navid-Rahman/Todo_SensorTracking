import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '/models/task_list.dart';

class TaskListDataStore {
  static const boxName = "taskLists";
  final Box<TaskList> box = Hive.box<TaskList>(boxName);

  /// Add new TaskList
  Future<void> addTaskList({required TaskList taskList}) async {
    await box.put(taskList.id, taskList);
  }

  /// Show TaskList
  Future<TaskList?> getTaskList({required String id}) async {
    return box.get(id);
  }

  /// Update TaskList
  Future<void> updateTaskList({required TaskList taskList}) async {
    await taskList.save();
  }

  /// Delete TaskList
  Future<void> deleteTaskList({required TaskList taskList}) async {
    await taskList.delete();
  }

  ValueListenable<Box<TaskList>> listenToTaskLists() {
    return box.listenable();
  }
}
