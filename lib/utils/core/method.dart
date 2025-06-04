import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/utils/core/mock.dart';
import 'package:scheduleme/utils/core/supabase.dart';
import 'package:scheduleme/utils/core/types.dart';

const isMockingRequest = true;
final Method applicationMethod =
    isMockingRequest ? MockMethod() : SupabaseMethod();

abstract class Method {
  Future initialize();
  Future<Result<AuthMethod, MethodError>> getAuthMethod(String email);
  Future<Result<LoginResponse, MethodError>> singInWithPassword(
      String email, String password);
  Future<Result<GenericResponse, MethodError>> signUpWithEmail(
      String email, String password);

  Future<Result<LoginResponse, MethodError>> verifyEmail(
      String email, String code);
  Future<Result<SendVerificationMailResponse, MethodError>>
      sendVerificationToken(String email);

  // Appointment & Space
  Future<Result<GetAppointmentResponse, MethodError>> getAppointments(
      {String? purpose, String? status, DateTime? dateTime});

  Future<Result<GetAppointmentResponse, MethodError>> findAppointments(
      String keyword,
      {String? status});

  Future<Result<GetFormResponse, MethodError>> getAppointmentForm(
      String spaceId);
  Future<Result<GenericResponse, MethodError>> setDefaultAppointmentForm(
      String spaceId, String formId);
}

@immutable
class MethodError {
  final String code;
  final String? message;

  const MethodError(this.code, {this.message = "InternalServerError"});

  String get getMessage => message!;

  factory MethodError.from(dynamic source) {
    return MethodError(source['code'] ?? "500", message: source["message"]);
  }
}

enum ApiStatus {
  success,
  failed;

  static ApiStatus fromString(String str) => switch (str) {
        "success" => ApiStatus.success,
        _ => ApiStatus.failed, // fallback
      };
}

class ApiResponse<T> {
  static ApiResponse<T> decodeResponseFromString<T>(String str,
      {T Function(dynamic value)? data}) {
    final decoded = json.decode(str);
    return ApiResponse<T>(
      ApiStatus.fromString(decoded["status"]),
      data: decoded["data"] != null && data != null
          ? Some(data(decoded["data"]))
          : const None(),
      error: decoded["error"] != null
          ? Some(MethodError.from(decoded["error"]))
          : const None(),
    );
  }

  static ApiResponse<T> decodeResponseFromJson<T>(Map<String, dynamic> jsonData,
      {T Function(dynamic value)? data}) {
    return ApiResponse<T>(
      ApiStatus.fromString(jsonData["status"]),
      data: jsonData["data"] != null && data != null
          ? Some(data(jsonData["data"]))
          : const None(),
      error: jsonData["error"] != null
          ? Some(MethodError.from(jsonData["error"]))
          : const None(),
    );
  }

  ApiResponse(this.status, {required this.data, required this.error});

  final ApiStatus status;
  final Option<T> data;
  final Option<MethodError> error;
}
