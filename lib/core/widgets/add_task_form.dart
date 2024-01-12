import 'package:flutter/material.dart';
import 'package:pmdr/models/task/task.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter Task',
            ),
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                Task newTask = Task(taskName: _controller.text);
                Navigator.pop(context, newTask);
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text('Add')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
      ],
    );
  }
}
