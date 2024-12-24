import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.notifier.g.dart';

@riverpod
Future<dynamic> checkAuth(Ref ref) async {}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<dynamic> build() async => {};
}
