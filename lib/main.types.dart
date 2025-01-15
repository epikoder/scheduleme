part of 'main.dart';

void registerConstructors() {
  TypeRegistry.instance.registerType<LoginResponse>(() => LoginResponse());
  TypeRegistry.instance
      .registerType<AuthMethod>(() => AuthMethod.credentials);
}
