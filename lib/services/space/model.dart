import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

enum SpaceType { organisation, estate }

@JsonSerializable()
class Space {
  Space({
    required this.spaceType,
    this.members = const [],
  });

  @JsonKey(name: "space_type")
  final SpaceType spaceType;
  List<String> members;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);
}
