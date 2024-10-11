import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_list.g.dart';

@HiveType(typeId: 0)
class TaskList extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  TaskList({required this.id, required this.title});

  factory TaskList.create({required String title}) {
    return TaskList(
      id: const Uuid().v4(),
      title: title,
    );
  }
}
