import 'package:flutter/material.dart';
import '/utils/base_page.dart';

import '/constants/app_colors.dart';

class TodoListHomeScreen extends StatelessWidget {
  const TodoListHomeScreen({super.key});

  static const String routeName = 'todo_list_home';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff33CCCC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: null,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Column(
        children: [
          const SizedBox(height: 30),
          _topHeaderContainer(5, 6),
          const Divider(color: Color(0xffCFCFCF)),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _taskListView('Task List $index', '$index');
            },
          )
        ],
      ),
    );
  }

  Widget _taskListView(String title, String taskCount) {
    return Card(
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
            const Icon(
              Icons.list_sharp,
              color: AppColors.primaryColor,
              size: 28,
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
            const Icon(
              Icons.search,
              color: Colors.black,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
