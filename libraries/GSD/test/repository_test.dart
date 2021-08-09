import 'dart:math';

import 'package:gsd_domain/gsd_domain.dart';
import 'package:test/test.dart';

void main() {
  late TaskRepository repo;
  late Task sampleTask1;
  late Task sampleTask2;

  setUp(() {
    repo = TaskRepository.shared;
    sampleTask1 = Task(
        description: 'Create Package',
        content: 'Content',
        state: TaskState.toDo);
    sampleTask2 = Task.done(description: 'Run tests', content: 'Content');
  });

  tearDown(() {
    repo.reset();
  });

  group('Creation & Accessors', () {
    test('Empty Repo', () {
      expect(TaskRepository.shared, isNotNull);
      expect(() => repo.length, returnsNormally);
      expect(repo.length, 0);
    });
  });

  group('Mutators', () {
    test('add añade siempre al principio', () {
      repo.add(sampleTask1);
      expect(repo[0], sampleTask1);
    });

    test('Can add several times the same task', () {
      repo.add(sampleTask2);
      repo.add(sampleTask2);
      expect(repo.length, 2);
    });

    test('insert: adds at the corresponding index', () {
      expect(() => repo.insert(10, sampleTask2), throwsRangeError);
      expect(() => repo.insert(0, sampleTask1), returnsNormally);

      final newTask =
          Task.done(description: 'test the insertion', content: 'Content');
      repo.insert(1, newTask);
      expect(repo[1], newTask);
      expect(repo.length, 2);
    });

    /// ToDO:
    /// Comprobar removeAt
    /// Comprobar move
  });
}
