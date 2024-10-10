import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/utils/base_page.dart';

class AddListTitle extends StatefulWidget {
  const AddListTitle({super.key});

  static const String routeName = 'add_list_title';

  @override
  State<AddListTitle> createState() => _AddListTitleState();
}

class _AddListTitleState extends State<AddListTitle> {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Save the title when the keyboard is closed
        _saveTitle(_titleController.text);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveTitle(String title) {
    // Implement your save logic here
    print('Title saved: $title');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      appBarTitle: 'Lists',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _titleController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Untitled List',
                hintStyle: TextStyle(
                  color: Color(0xffB8B8B8),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
