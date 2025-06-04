import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum SpaceType { organisation, estate }

@JsonSerializable()
class Space {
  Space({
    required this.id,
    required this.spaceType,
    this.members = const [],
  });

  final String id;
  @JsonKey(name: "space_type")
  final SpaceType spaceType;
  List<String> members;

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);
}

@JsonSerializable()
class SpacePartedInfo {
  SpacePartedInfo({
    required this.id,
    required this.spaceType,
    required this.title,
    required this.isOwner,
    required this.members,
  });

  final String id;

  @JsonKey(name: "space_type")
  final SpaceType spaceType;
  final String title;
  final int members;

  @JsonKey(name: "is_owner")
  final bool isOwner;

  factory SpacePartedInfo.fromJson(Map<String, dynamic> json) =>
      _$SpacePartedInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SpacePartedInfoToJson(this);
}
