import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Member {
  Member();

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}
