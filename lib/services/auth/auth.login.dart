import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/utils/logger.dart';
import 'package:scheduleme/utils/type_registry.dart';
import 'package:scheduleme/constants/api_url.dart';
import 'package:scheduleme/services/auth/model.dart';
import 'package:scheduleme/utils/net_tools.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth.login.g.dart';

@freezed
class LoginResponse implements From<LoginResponse> {
  LoginResponse({this.user, this.tokens});

  User? user;
  (String, String)? tokens;

  @override
  LoginResponse from(dynamic source) {
    return LoginResponse(
      user: source['user'] != null ? User.fromJson(source['user']) : null,
      tokens: source['tokens'] != null
          ? (
              source['tokens']['access_token'],
              source['tokens']['refresh_token']
            )
          : null,
    );
  }
}

enum AuthMethod implements From<AuthMethod> {
  credentials,
  google,
  none;

  @override
  AuthMethod from(dynamic source) {
    return AuthMethod.values.firstWhere(
      (e) => e.name == source,
      orElse: () => AuthMethod.none, // Default fallback
    );
  }
}

@riverpod
class Login extends _$Login {
  @override
  AsyncValue<LoginResponse?> build() => const AsyncValue.data(null);

  Future<void> loginWithCredendials(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      logger.d("sending request...");
      final response =
          await Client.instance.post(Uri.parse(ApiURL.login), body: {
        "email": email,
        "password": password,
      });
      final rv = ApiResponse.decodeResponse<LoginResponse>(response.body);
      state = AsyncValue.data(rv.data);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

@riverpod
class FindAuthMethod extends _$FindAuthMethod {
  @override
  AsyncValue<AuthMethod?> build() => const AsyncValue.data(null);

  Future<void> findProvider(String email) async {
    state = const AsyncValue.loading();
    try {
      final response =
          await Client.instance.get(Uri.parse("${ApiURL.login}?email=$email"));
      final rv = ApiResponse.decodeResponse<AuthMethod>(response.body);
      state = AsyncValue.data(rv.data);
    } catch (error, __) {
      logger.e(error);
      state = const AsyncValue.data(null);
    }
  }
}
