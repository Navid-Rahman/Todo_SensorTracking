import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String taskListId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  TimeOfDay? dueTime;

  @HiveField(6)
  bool isCompleted;

  @HiveField(7)
  bool isStarred;

  Task({
    required this.id,
    required this.taskListId,
    required this.title,
    this.description,
    this.dueDate,
    this.dueTime,
    this.isCompleted = false,
    this.isStarred = false,
  });

  factory Task.create({
    required String taskListId,
    required String title,
    String? description,
    DateTime? dueDate,
    TimeOfDay? dueTime,
    bool isCompleted = false,
    bool isStarred = false,
  }) {
    return Task(
      id: const Uuid().v4(),
      taskListId: taskListId,
      title: title,
      description: description,
      dueDate: dueDate,
      dueTime: dueTime,
      isCompleted: isCompleted,
      isStarred: isStarred,
    );
  }
}
