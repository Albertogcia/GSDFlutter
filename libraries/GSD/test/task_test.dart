import 'package:gsd_domain/gsd_domain.dart';
import 'package:test/test.dart';

void main() {
  group('ImmutableTask', () {
    setUp(() {
      // Additional setup goes here.
    });
    tearDown(() {});

    test('Creation', () {
      expect(ImmutableTask(description: 'Compilar'), isNotNull);
    });

    test('equality', () {
      final iTask1 = ImmutableTask(description: 'Pasar los tests');

      expect(iTask1 == iTask1, isTrue);

      expect(ImmutableTask(description: 'comprar leche'),
          ImmutableTask(description: 'comprar leche'));

      expect(
          ImmutableTask(description: 'tarea 1') !=
              ImmutableTask(description: 'Tarea 2'),
          isTrue);
    });

    test('dos objetos iguales deben de tener el mismo hashCode', () {
      const desc = 'tarea 1';
      final t1 = ImmutableTask(description: desc);
      final t2 = ImmutableTask(description: desc);

      expect(t1.hashCode, t2.hashCode);
    });
  });

  group('Task', () {
    // Test de creación, igualdad & hashCode
  });
}
