import 'package:flutter/material.dart';
import 'package:gsd_domain/gsd_domain.dart';

class TaskDetails extends StatelessWidget {
  late final Task task;
  late final int index;

  final TextEditingController descriptionTextEditingController =
      TextEditingController();
  final TextEditingController contentTextEditingController =
      TextEditingController();

  TaskDetails({required Task task, required int index}) {
    this.task = task;
    this.index = index;
    descriptionTextEditingController.text = task.description;
    contentTextEditingController.text = task.content;
  }

  void _updateTask(BuildContext context) {
    TaskRepository.shared.updateTaskData(
        index,
        descriptionTextEditingController.text,
        contentTextEditingController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                  controller: descriptionTextEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(border: UnderlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text('Content',
                  textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                  controller: contentTextEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(border: UnderlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    _updateTask(context);
                  },
                  child: const Text('Update'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
