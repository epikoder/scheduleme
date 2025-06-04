import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduleme/services/auth/model.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:scheduleme/utils/logger.dart';

//
// Auth Types
//
@freezed
class LoginResponse {
  LoginResponse({this.user, this.tokens, this.code, this.email});

  User? user;
  (String, String)? tokens;
  int? code;
  String? email;

  factory LoginResponse.from(Map<String, dynamic> source) {
    return LoginResponse(
      user: source['user'] != null ? User.fromJson(source['user']) : null,
      tokens: source['tokens'] != null
          ? (
              source['tokens']['access_token'],
              source['tokens']['refresh_token']
            )
          : null,
      code: source["code"],
      email: source["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user?.toJson(),
      "tokens": [tokens?.$1, tokens?.$2],
      "code": code,
      "email": email,
    };
  }
}

enum AuthMethod {
  credentials,
  google,
  none;

  factory AuthMethod.from(String source) {
    return AuthMethod.values.firstWhere(
      (e) => e.name.toLowerCase() == source.toLowerCase(),
      orElse: () => AuthMethod.none, // Default fallback
    );
  }
}

enum SendVerificationMailResponse {
  success,
  failed,
  tooManyRequest;

  factory SendVerificationMailResponse.from(dynamic source) {
    if (source.runtimeType != String) {
      return SendVerificationMailResponse.failed;
    }
    return switch (source) {
      "success" => SendVerificationMailResponse.success,
      _ => SendVerificationMailResponse.failed,
    };
  }
}

//
// Appointment & Space
//

class GetAppointmentResponse {
  GetAppointmentResponse({this.appointments = const []});
  final List<Appointment> appointments;

  factory GetAppointmentResponse.from(source) {
    final appointments = <Appointment>[];
    for (final appointment in source) {
      try {
        appointments.add(Appointment.fromJson(appointment));
      } catch (e, stackTrace) {
        logger.e(e, stackTrace: stackTrace);
      }
    }
    return GetAppointmentResponse(appointments: appointments);
  }
}

class GetFormResponse {
  GetFormResponse({required this.appointmentForms});
  final List<AppointmentForm> appointmentForms;

  factory GetFormResponse.from(List<Map<String, dynamic>> source) {
    return GetFormResponse(
      appointmentForms:
          source.map((form) => AppointmentForm.fromJson(form)).toList(),
    );
  }
}

//
// Default empty response
//
@JsonSerializable()
class GenericResponse {
  GenericResponse();
  @override
  factory GenericResponse.from(dynamic _) => GenericResponse();
}
