import 'package:option_result/option_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';

part 'email_verification.g.dart';

@riverpod
class VerifyEmail extends _$VerifyEmail {
  @override
  AsyncValue<Option<LoginResponse>> build() {
    return const AsyncValue.data(None());
  }

  Future<void> verifyEmail(String email, String code) async {
    state = const AsyncValue.loading();
    final result = await applicationMethod.verifyEmail(email, code);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        state = AsyncValue.error(value, StackTrace.current);
    }
  }
}

@riverpod
class SendVerificationToken extends _$SendVerificationToken {
  @override
  AsyncValue<Option<SendVerificationMailResponse>> build() {
    return const AsyncValue.data(None());
  }

  Future<void> sendVerificationToken(String email) async {
    state = const AsyncValue.loading();
    final result = await applicationMethod.sendVerificationToken(email);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        state = AsyncValue.error(value, StackTrace.current);
    }
  }
}
