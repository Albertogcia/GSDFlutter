import 'package:flutter/material.dart';
import 'package:gsd_app/domain/settings.dart';
import 'package:gsd_domain/gsd_domain.dart';
import 'package:mow/mow.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsHeader(),
          DoneHeader(),
          FutureBuilder<Settings>(
            future: Settings.getInstance(defaultOption: 0),
            builder: (BuildContext context, AsyncSnapshot<Settings> snap) {
              if (snap.hasData) {
                return DoneOptions(model: snap.data!);
              } else {
                return DoneEmptyOptions();
              }
            },
          )
        ],
      ),
    );
  }
}

class DoneOptions extends ModelWidget<Settings> {
  DoneOptions({required Settings model, Key? key})
      : super(model: model, key: key);
  @override
  _DoneOptionsState createState() => _DoneOptionsState();
}

Future<bool?> _showConfirmDeleteDialog(BuildContext context) async {
  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete done tasks'),
          content:
              const Text('Are you sure you want to delete completed tasks?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      });
}

class _DoneOptionsState extends ObserverState<Settings, DoneOptions> {
  @override
  Widget build(BuildContext context) {
    final int selectedOption = widget.model.selectedOption;
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Center(
        child: ToggleButtons(
            onPressed: (int index) async {
              switch (index) {
                case 0:
                  widget.model.selectedOption = index;
                  TaskRepository.shared.changeDoneTasksToNormalColor();
                  break;
                case 1:
                  widget.model.selectedOption = index;
                  TaskRepository.shared.changeDoneTasksToGreyColor();
                  break;
                case 2:
                  if (await _showConfirmDeleteDialog(context) ?? false) {
                    TaskRepository.shared.deleteDoneTasks();
                    widget.model.selectedOption = index;
                  }
                  break;
                default:
              }
            },
            isSelected: [
              selectedOption == 0,
              selectedOption == 1,
              selectedOption == 2
            ],
            direction: Axis.vertical,
            children: const [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Nothing')),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Grey out')),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Delete'))
            ]),
      ),
    );
  }
}

class DoneEmptyOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Center(
        child: ToggleButtons(
            onPressed: (int index) {},
            isSelected: const [false, false, false],
            direction: Axis.vertical,
            children: const [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Nothing')),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Grey out')),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text('Delete'))
            ]),
      ),
    );
  }
}

class DoneHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(Icons.done, size: 30),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'What to do with "done" tasks?',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        children: const [
          Icon(Icons.settings, size: 64, color: Colors.white),
          SizedBox(
            width: 15,
          ),
          Text(
            'Settings',
            style: TextStyle(fontSize: 42, color: Colors.white),
          )
        ],
      ),
    );
  }
}
