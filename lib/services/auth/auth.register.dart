import 'package:option_result/option_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
part 'auth.register.g.dart';

@riverpod
class Register extends _$Register {
  @override
  AsyncValue<Option<GenericResponse>> build() => const AsyncValue.data(None());

  Future<void> registerWithCredentials(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await applicationMethod.signUpWithEmail(email, password);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        {
          state = AsyncValue.error(value, StackTrace.empty);
        }
    }
  }
}
