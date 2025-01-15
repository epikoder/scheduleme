// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      profile: json['meta_data'] == null
          ? null
          : Profile.fromJson(json['meta_data'] as Map<String, dynamic>),
      profiles: (json['profiles'] as List<dynamic>?)
              ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'profiles': instance.profiles,
      'meta_data': instance.profile,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      fullName: json['full_name'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'phone': instance.phone,
    };

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      code: (json['code'] as num).toInt(),
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'code': instance.code,
      'phone': instance.phone,
    };
