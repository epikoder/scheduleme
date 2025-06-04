import 'package:json_annotation/json_annotation.dart';
import 'package:option_result/option.dart';

class OptionStringConverter extends JsonConverter<Option<String>, String?> {
  const OptionStringConverter();

  @override
  fromJson(json) => json != null ? Some(json) : const None();

  @override
  toJson(object) => object.isNone() ? null : object.unwrap();
}
