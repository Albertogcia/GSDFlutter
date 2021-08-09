import 'package:updatable/updatable.dart';

class ImmutableTask {
  late final String _description;

  String get description => _description;

  late final String _content;

  String get content => _content;

  ImmutableTask({required String description, required String content})
      : _description = description,
        _content = content;

  @override
  String toString() {
    return '<$runtimeType: $_description >';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is ImmutableTask && _description == other._description;
    }
  }

  @override
  int get hashCode => _description.hashCode;
}

class Task extends ImmutableTask with Updatable {
  late TaskState _state;
  TaskState get state => _state;
  set state(TaskState newValue) {
    if (newValue != _state) {
      changeState(() {
        _state = newValue;
      });
    }
  }

  bool isGrey = false;

  // Cosntructors
  Task(
      {required String description,
      required String content,
      required TaskState state})
      : _state = state,
        super(description: description, content: content);

  Task.done({required String description, required String content})
      : _state = TaskState.done,
        super(description: description, content: content);

  Task.toDo({required String description, required String content})
      : _state = TaskState.toDo,
        super(description: description, content: content);

  @override
  String toString() {
    return '<$runtimeType: $description $state>';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is Task &&
          description == other.description &&
          state == other.state;
    }
  }

  @override
  int get hashCode => _description.hashCode ^ _state.hashCode;
}

enum TaskState { done, toDo }
