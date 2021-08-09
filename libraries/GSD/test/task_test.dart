import 'package:gsd_domain/gsd_domain.dart';
import 'package:test/test.dart';

void main() {
  group('ImmutableTask', () {
    setUp(() {
      // Additional setup goes here.
    });
    tearDown(() {});

    test('Creation', () {
      expect(ImmutableTask(description: 'Compilar', content: 'Content'),
          isNotNull);
    });

    test('equality', () {
      final iTask1 =
          ImmutableTask(description: 'Pasar los tests', content: 'Content');

      expect(iTask1 == iTask1, isTrue);

      expect(ImmutableTask(description: 'comprar leche', content: 'Content'),
          ImmutableTask(description: 'comprar leche', content: 'Content'));

      expect(
          ImmutableTask(description: 'tarea 1', content: 'Content') !=
              ImmutableTask(description: 'Tarea 2', content: 'Content'),
          isTrue);
    });

    test('dos objetos iguales deben de tener el mismo hashCode', () {
      const desc = 'tarea 1';
      const content = 'Content';
      final t1 = ImmutableTask(description: desc, content: content);
      final t2 = ImmutableTask(description: desc, content: content);

      expect(t1.hashCode, t2.hashCode);
    });
  });

  group('Task', () {
    // Test de creación, igualdad & hashCode
  });
}
