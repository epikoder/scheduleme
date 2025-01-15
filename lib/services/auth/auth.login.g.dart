// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginHash() => r'7317900a3226cedf3182d19b31140b5a798c5d73';

/// See also [Login].
@ProviderFor(Login)
final loginProvider =
    AutoDisposeNotifierProvider<Login, AsyncValue<LoginResponse?>>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeNotifier<AsyncValue<LoginResponse?>>;
String _$findAuthMethodHash() => r'7da9ae8a2dd86d38bc19a68fae4270c472edb7d3';

/// See also [FindAuthMethod].
@ProviderFor(FindAuthMethod)
final findAuthMethodProvider = AutoDisposeNotifierProvider<FindAuthMethod,
    AsyncValue<AuthMethod?>>.internal(
  FindAuthMethod.new,
  name: r'findAuthMethodProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$findAuthMethodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FindAuthMethod = AutoDisposeNotifier<AsyncValue<AuthMethod?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
