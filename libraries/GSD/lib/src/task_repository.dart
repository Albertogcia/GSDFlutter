import 'package:gsd_domain/src/repository.dart';
import 'package:gsd_domain/src/task.dart';
import 'package:meta/meta.dart';
import 'package:updatable/updatable.dart';

class TaskRepository with Updatable implements Repository<Task> {
  final List<Task> _tasks = [];

  Task? _lastRemovedTask;
  int? _lastRemovedIndex;

  @override
  Task operator [](int index) {
    return _tasks[index];
  }

  // Métodos para devolver Tasks semi-configuradas
  Task done(String desc, String content) {
    final task = Task.done(description: desc, content: content);
    add(task);
    return task;
  }

  Task toDo(String desc, String content) {
    final task = Task.toDo(description: desc, content: content);
    add(task);
    return task;
  }

  // Singleton
  TaskRepository._single();
  static final shared = TaskRepository._single();

  // Mutators
  @override
  void add(Task element) {
    batchChangeState(() {
      _tasks.insert(0, element);
    });
  }

  @override
  void insert(int index, Task element) {
    changeState(() {
      _tasks.insert(index, element);
    });
  }

  @override
  // TODO: implement length
  int get length => _tasks.length;

  @override
  void move(int from, int to) {
    final tmp = _tasks[from];
    _tasks.removeAt(from);
    _tasks.insert(to, tmp);
  }

  @override
  void removeAt(int index) {
    changeState(() {
      final tmp = _tasks[index];
      _lastRemovedTask = tmp;
      _lastRemovedIndex = index;
      _tasks.removeAt(index);
    });
  }

  @override
  void undoLastDelete() {
    if (_lastRemovedIndex != null && _lastRemovedTask != null) {
      changeState(() {
        _tasks.insert(_lastRemovedIndex!, _lastRemovedTask!);
        _lastRemovedIndex = null;
        _lastRemovedTask = null;
      });
    }
  }

  void changeDoneTasksToNormalColor() {
    for (final task in _tasks) {
      if (task.state == TaskState.done) {
        task.isGrey = false;
      }
    }
    changeState(() {});
  }

  void changeDoneTasksToGreyColor() {
    for (final task in _tasks) {
      if (task.state == TaskState.done) {
        task.isGrey = true;
      }
    }
    changeState(() {});
  }

  void deleteDoneTasks() {
    _tasks.removeWhere((task) => task.state == TaskState.done);
    changeState(() {});
  }

  void updateTaskData(int index, String description, String content) {
    changeState(() {
      final task = _tasks[index];
      task.description = description;
      task.content = content;
    });
  }
}

extension Testing on TaskRepository {
  @visibleForTesting
  void reset() {
    changeState(() {
      _tasks.clear();
    });
  }
}
