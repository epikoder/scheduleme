class TypeRegistry {
  TypeRegistry._();
  static final _instance = TypeRegistry._();
  static TypeRegistry get instance => _instance;

  final Map<Type, From Function()> _constructors = {};

  void registerType<T>(From<T> Function() constructor) {
    _constructors[T] = constructor;
  }

  T make<T extends From<T>>(dynamic source) {
    final constructor = _constructors[T];
    if (constructor == null) {
      throw ArgumentError('No constructor registered for type $T');
    }
    return constructor().from(source);
  }
}

abstract class From<T> {
  const From();
  T from(dynamic source);
}