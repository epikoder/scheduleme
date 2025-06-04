import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/utils/option_ext.dart';

part "model.g.dart";

enum AppointmentStatus {
  upcoming,
  scheduled,
  completed,
  expired,
  rescheduled,
  cancelled;

  static AppointmentStatus fromString(String s) {
    final status = s.toLowerCase();
    return switch (status) {
      "completed" => AppointmentStatus.completed,
      "expired" => AppointmentStatus.expired,
      "cancelled" => AppointmentStatus.cancelled,
      "rescheduled" => AppointmentStatus.rescheduled,
      _ => AppointmentStatus.scheduled,
    };
  }

  String get string => switch (name) {
        "upcoming" => AppointmentStatus.scheduled.name,
        _ => name
      };
}

enum AppointmentType {
  visit,
  meeting;

  static AppointmentType fromString(String s) {
    final type = s.toLowerCase();
    return switch (type) {
      "visit" => AppointmentType.visit,
      _ => AppointmentType.meeting,
    };
  }

  String get string => name;
}

extension ColorExtension on Color {
  /// Convert a hex string (e.g., "#RRGGBB" or "RRGGBB") to a Color
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) {
      if (hex.startsWith('#')) hex = hex.substring(1);
      buffer.write('ff'); // Default alpha value
    }
    buffer.write(hex);
    return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0x00ffffff);
  }

  /// Convert a Color to a hex string (e.g., "#RRGGBB")
  String toHex() {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
  }
}

class ColorConverter extends JsonConverter<Color, String> {
  const ColorConverter();
  @override
  Color fromJson(String json) => ColorExtension.fromHex(json);

  @override
  String toJson(Color object) => object.toHex();
}

@JsonSerializable()
class AppointmentTag {
  AppointmentTag({
    required this.id,
    required this.name,
    required this.color,
  });

  final String id;
  final String name;

  @ColorConverter()
  final Color color;

  factory AppointmentTag.fromJson(Map<String, dynamic> json) =>
      _$AppointmentTagFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentTagToJson(this);
}

@JsonSerializable()
class Host {
  Host({required this.hostId, required this.hostName});

  @JsonKey(name: "host_id")
  final String hostId;

  @JsonKey(name: "host_name")
  final String hostName;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
  Map<String, dynamic> toJson() => _$HostToJson(this);
}

@JsonSerializable()
class Participant {
  Participant({
    required this.participantId,
    required this.name,
    required this.email,
    required this.photo,
    this.meta = const {},
  });

  @JsonKey(name: "id")
  final String participantId;

  final String name;
  final String email;

  @OptionStringConverter()
  final Option<String> photo;

  final Map<String, dynamic> meta;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}

@JsonSerializable()
class Appointment {
  const Appointment({
    required this.id,
    required this.appointmentType,
    required this.title,
    required this.duration,
    required this.tag,
    required this.status,
    required this.host,
    required this.participants,
    required this.dateTime,
    this.location = const None(),
    this.notes = const None(),
    this.meta = const {},
  });

  final String id;

  @JsonKey(name: "appointment_type")
  final AppointmentType appointmentType;

  final String title;
  final int duration;

  @JsonKey(name: "tag")
  final AppointmentTag tag;

  final AppointmentStatus status;
  final Host host;
  final List<Participant> participants;

  @JsonKey(name: "date_time")
  final DateTime dateTime;

  @OptionStringConverter()
  final Option<String> location;

  @OptionStringConverter()
  final Option<String> notes;

  final Map<String, dynamic> meta;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

@JsonSerializable()
class AppointmentForm {
  const AppointmentForm({
    required this.id,
    required this.name,
    required this.dateTime,
    this.isDefault,
  });

  final String id;
  final String name;
  final DateTime dateTime;
  final bool? isDefault;

  factory AppointmentForm.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFormFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentFormToJson(this);
}
