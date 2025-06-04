// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentTag _$AppointmentTagFromJson(Map<String, dynamic> json) =>
    AppointmentTag(
      id: json['id'] as String,
      name: json['name'] as String,
      color: const ColorConverter().fromJson(json['color'] as String),
    );

Map<String, dynamic> _$AppointmentTagToJson(AppointmentTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': const ColorConverter().toJson(instance.color),
    };

Host _$HostFromJson(Map<String, dynamic> json) => Host(
      hostId: json['host_id'] as String,
      hostName: json['host_name'] as String,
    );

Map<String, dynamic> _$HostToJson(Host instance) => <String, dynamic>{
      'host_id': instance.hostId,
      'host_name': instance.hostName,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      participantId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photo: const OptionStringConverter().fromJson(json['photo'] as String?),
      meta: json['meta'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.participantId,
      'name': instance.name,
      'email': instance.email,
      'photo': const OptionStringConverter().toJson(instance.photo),
      'meta': instance.meta,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as String,
      appointmentType:
          $enumDecode(_$AppointmentTypeEnumMap, json['appointment_type']),
      title: json['title'] as String,
      duration: (json['duration'] as num).toInt(),
      tag: AppointmentTag.fromJson(json['tag'] as Map<String, dynamic>),
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      host: Host.fromJson(json['host'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateTime: DateTime.parse(json['date_time'] as String),
      location: json['location'] == null
          ? const None()
          : const OptionStringConverter().fromJson(json['location'] as String?),
      notes: json['notes'] == null
          ? const None()
          : const OptionStringConverter().fromJson(json['notes'] as String?),
      meta: json['meta'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_type': _$AppointmentTypeEnumMap[instance.appointmentType]!,
      'title': instance.title,
      'duration': instance.duration,
      'tag': instance.tag,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'host': instance.host,
      'participants': instance.participants,
      'date_time': instance.dateTime.toIso8601String(),
      'location': const OptionStringConverter().toJson(instance.location),
      'notes': const OptionStringConverter().toJson(instance.notes),
      'meta': instance.meta,
    };

const _$AppointmentTypeEnumMap = {
  AppointmentType.visit: 'visit',
  AppointmentType.meeting: 'meeting',
};

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.upcoming: 'upcoming',
  AppointmentStatus.scheduled: 'scheduled',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.expired: 'expired',
  AppointmentStatus.rescheduled: 'rescheduled',
  AppointmentStatus.cancelled: 'cancelled',
};

AppointmentForm _$AppointmentFormFromJson(Map<String, dynamic> json) =>
    AppointmentForm(
      id: json['id'] as String,
      name: json['name'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$AppointmentFormToJson(AppointmentForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateTime': instance.dateTime.toIso8601String(),
      'isDefault': instance.isDefault,
    };
