// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.login.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginHash() => r'873b176f981fc237bd252427a8809b44b612c352';

/// See also [Login].
@ProviderFor(Login)
final loginProvider = AutoDisposeNotifierProvider<Login,
    AsyncValue<Option<LoginResponse>>>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeNotifier<AsyncValue<Option<LoginResponse>>>;
String _$findAuthMethodHash() => r'085da36531a9d82bffd94e6bcfdfc140295e958b';

/// See also [FindAuthMethod].
@ProviderFor(FindAuthMethod)
final findAuthMethodProvider = AutoDisposeNotifierProvider<FindAuthMethod,
    AsyncValue<Option<AuthMethod>>>.internal(
  FindAuthMethod.new,
  name: r'findAuthMethodProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$findAuthMethodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FindAuthMethod = AutoDisposeNotifier<AsyncValue<Option<AuthMethod>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
