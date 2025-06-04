import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
part 'auth.login.g.dart';

@riverpod
class Login extends _$Login {
  @override
  AsyncValue<Option<LoginResponse>> build() => const AsyncValue.data(None());

  Future<void> loginWithCredentials(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await applicationMethod.singInWithPassword(email, password);
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
class FindAuthMethod extends _$FindAuthMethod {
  @override
  AsyncValue<Option<AuthMethod>> build() => const AsyncValue.data(None());

  Future<void> findProvider(String email) async {
    state = const AsyncValue.loading();
    final result = await applicationMethod.getAuthMethod(email);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        state = AsyncValue.error(value, StackTrace.current);
    }
  }

  Future<void> useAuthMethod(AuthMethod method) async {
    state = AsyncValue.data(Some(method));
  }
}
