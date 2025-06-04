// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      id: json['id'] as String,
      spaceType: $enumDecode(_$SpaceTypeEnumMap, json['space_type']),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      'id': instance.id,
      'space_type': _$SpaceTypeEnumMap[instance.spaceType]!,
      'members': instance.members,
    };

const _$SpaceTypeEnumMap = {
  SpaceType.organisation: 'organisation',
  SpaceType.estate: 'estate',
};

SpacePartedInfo _$SpacePartedInfoFromJson(Map<String, dynamic> json) =>
    SpacePartedInfo(
      id: json['id'] as String,
      spaceType: $enumDecode(_$SpaceTypeEnumMap, json['space_type']),
      title: json['title'] as String,
      isOwner: json['is_owner'] as bool,
      members: (json['members'] as num).toInt(),
    );

Map<String, dynamic> _$SpacePartedInfoToJson(SpacePartedInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'space_type': _$SpaceTypeEnumMap[instance.spaceType]!,
      'title': instance.title,
      'members': instance.members,
      'is_owner': instance.isOwner,
    };
