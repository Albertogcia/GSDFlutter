import 'package:flutter/material.dart';
import 'package:gsd_domain/gsd_domain.dart';

class TaskDetails extends StatelessWidget {
  late final Task task;

  TaskDetails({required Task task}) : task = task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(task.description, textAlign: TextAlign.start),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text('Content',
                  textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(task.content, textAlign: TextAlign.start),
            ),
          ],
        ),
      ),
    );
  }
}
