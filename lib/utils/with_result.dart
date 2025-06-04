import 'package:option_result/option_result.dart';

Result<T, Object> withResult<T>(T Function() fn) {
  try {
    return Ok(fn());
  } catch (e) {
    return Err(e);
  }
}

Future<Result<T, Object>> withResultAsync<T>(Future<T> Function() fn) async {
  try {
    return Ok(await fn());
  } catch (e) {
    return Err(e);
  }
}
