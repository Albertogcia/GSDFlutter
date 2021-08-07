abstract class Repository<Element> {
  // Accessors
  int get length;
  Element operator [](int index);

  // Mutators
  void add(Element element);
  void insert(int index, Element element);
  void removeAt(int index);
  void move(int from, int to);
  void undoLastDelete();
}
