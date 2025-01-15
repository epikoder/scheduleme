// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Space _$SpaceFromJson(Map<String, dynamic> json) => Space(
      spaceType: $enumDecode(_$SpaceTypeEnumMap, json['space_type']),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SpaceToJson(Space instance) => <String, dynamic>{
      'space_type': _$SpaceTypeEnumMap[instance.spaceType]!,
      'members': instance.members,
    };

const _$SpaceTypeEnumMap = {
  SpaceType.organisation: 'organisation',
  SpaceType.estate: 'estate',
};
