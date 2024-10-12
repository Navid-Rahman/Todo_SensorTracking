import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_sensor_tracking/constants/assets.dart';

import '../add_task/add_task_screen.dart';

import '../add_list_title.dart';
import '/constants/app_colors.dart';
import '/data/task_data_store.dart';
import '/data/task_list_data_store.dart';
import '/models/task.dart';
import '/models/task_list.dart';
import '/utils/base_page.dart';

class TodoListHomeScreen extends StatefulWidget {
  const TodoListHomeScreen({super.key});

  static const String routeName = 'todo_list_home';

  @override
  State<TodoListHomeScreen> createState() => _TodoListHomeScreenState();
}

class _TodoListHomeScreenState extends State<TodoListHomeScreen> {
  late Box<TaskList> _taskListsBox;
  final TaskDataStore _taskDataStore = TaskDataStore();

  @override
  void initState() {
    super.initState();
    _taskListsBox = Hive.box<TaskList>(TaskListDataStore.boxName);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff33CCCC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddListTitle.routeName);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Column(
        children: [
          const SizedBox(height: 30),
          ValueListenableBuilder(
            valueListenable: _taskDataStore.listenToTasks(),
            builder: (context, Box<Task> taskBox, _) {
              final tasks = _taskDataStore.getAllTasks();
              final incompleteCount =
                  tasks.where((task) => !task.isCompleted).length;
              final completedCount =
                  tasks.where((task) => task.isCompleted).length;

              return _topHeaderContainer(incompleteCount, completedCount);
            },
          ),
          const Divider(color: Color(0xffCFCFCF)),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _taskListsBox.listenable(),
              builder: (context, Box<TaskList> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text('No task lists available'),
                  );
                }

                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    TaskList taskList = box.getAt(index)!;
                    return ValueListenableBuilder(
                      valueListenable: _taskDataStore.listenToTasks(),
                      builder: (context, Box<Task> taskBox, _) {
                        int taskCount = _taskDataStore
                            .getTaskCountByTaskListId(taskList.id);
                        return _taskListView(
                          taskList.title,
                          taskCount.toString(),
                          () {
                            Navigator.pushNamed(
                              context,
                              AddTaskScreen.routeName,
                              arguments: {
                                'taskListId': taskList.id,
                                'taskTitle': taskList.title,
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskListView(String title, String taskCount, final Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        shadowColor: const Color(0xff575767).withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Icon(
              //   Icons.list_sharp,
              //   color: AppColors.primaryColor,
              //   size: 28,
              // ),

              SvgPicture.asset(
                Assets.taskTitleIcon,
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
              ),
              const Spacer(),
              Text(
                taskCount,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topHeaderContainer(int incompleteCount, int completedCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://navidrahman.me/assets/navid-rahman-profile.jpg',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Navid Rahman',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$incompleteCount incomplete',
                        style: const TextStyle(
                          color: Color(0xff575767),
                          fontSize: 14,
                        ),
                      ),
                      const TextSpan(
                        text: ', ',
                        style: TextStyle(
                          color: Color(0xff575767),
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: '$completedCount completed',
                        style: const TextStyle(
                          color: Color(0xff575767),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            // const Icon(
            //   Icons.search,
            //   color: Colors.black,
            //   size: 40,
            // ),

            SvgPicture.asset(
              Assets.searchIcon,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}
