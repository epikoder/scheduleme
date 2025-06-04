// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyEmailHash() => r'2d55e1d702fce26b9a82cfbd56064685ad08cbca';

/// See also [VerifyEmail].
@ProviderFor(VerifyEmail)
final verifyEmailProvider = AutoDisposeNotifierProvider<VerifyEmail,
    AsyncValue<Option<LoginResponse>>>.internal(
  VerifyEmail.new,
  name: r'verifyEmailProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$verifyEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VerifyEmail = AutoDisposeNotifier<AsyncValue<Option<LoginResponse>>>;
String _$sendVerificationTokenHash() =>
    r'0385a191786a4f790f2b89be8f4b25eecc50b4fa';

/// See also [SendVerificationToken].
@ProviderFor(SendVerificationToken)
final sendVerificationTokenProvider = AutoDisposeNotifierProvider<
    SendVerificationToken,
    AsyncValue<Option<SendVerificationMailResponse>>>.internal(
  SendVerificationToken.new,
  name: r'sendVerificationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendVerificationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendVerificationToken
    = AutoDisposeNotifier<AsyncValue<Option<SendVerificationMailResponse>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
