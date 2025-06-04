import 'dart:io';
import 'package:option_result/result.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
import 'package:scheduleme/utils/with_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMethod implements Method {
  @override
  Future initialize() async {
    await Supabase.initialize(
        url: "https://mbwvqdhwzeaclrsnyygj.supabase.co",
        anonKey:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1id3ZxZGh3emVhY2xyc255eWdqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzOTI1NzYsImV4cCI6MjA2MDk2ODU3Nn0.wcdZ_Z0QFXSavwMKkInJcuL9FvZ_XYenOZgH_fj8JAQ");
    client = Supabase.instance.client;
  }

  late SupabaseClient client;

  @override
  Future<Result<AuthMethod, MethodError>> getAuthMethod(String email) async {
    final result = await withResultAsync(
        () => client.from("auth_methods").select().eq("email", email).single());
    switch (result) {
      case Ok(:final value):
        {
          return Ok(AuthMethod.from(value["provider"]));
        }
      case Err(:final value):
        {
          if (value is PostgrestException) {
            return Err(
                MethodError(value.code!, message: value.details.toString()));
          } else if (value is SocketException) {
            return const Err(MethodError("500", message: "Network Error"));
          } else {
            return const Err(MethodError("500"));
          }
        }
    }
  }

  @override
  Future<Result<GenericResponse, MethodError>> signUpWithEmail(
      String email, String password) async {
    final result = await withResultAsync(
        () => client.auth.signUp(password: password, email: email));
    switch (result) {
      case Ok():
        {
          return Ok(GenericResponse());
        }
      case Err(:final value):
        {
          if (value is PostgrestException) {
            return Err(
                MethodError(value.code!, message: value.details.toString()));
          } else if (value is SocketException) {
            return const Err(MethodError("500", message: "Network Error"));
          } else if (value is AuthException) {
            return Err(MethodError(value.statusCode!, message: value.message));
          } else {
            return const Err(MethodError("500"));
          }
        }
    }
  }

  @override
  Future<Result<LoginResponse, MethodError>> singInWithPassword(
      String email, String password) async {
    final result = await withResultAsync(
        () => client.auth.signInWithPassword(password: password, email: email));
    switch (result) {
      case Ok(:final value):
        {
          return Ok(LoginResponse.from({}));
        }
      case Err(:final value):
        {
          if (value is PostgrestException) {
            return Err(
                MethodError(value.code!, message: value.details.toString()));
          } else if (value is SocketException) {
            return const Err(MethodError("500", message: "Network Error"));
          } else {
            print(value);
            return const Err(MethodError("500"));
          }
        }
    }
  }

  @override
  Future<Result<SendVerificationMailResponse, MethodError>>
      sendVerificationToken(String email) async {
    final result = (await withResultAsync(() => client.functions.invoke(
            "scheduleme",
            method: HttpMethod.post,
            headers: {"rpc": "request-email-verification"},
            body: {"email": email})))
        .map((value) =>
            ApiResponse.decodeResponseFromJson<SendVerificationMailResponse>(
                value.data,
                data: (value) => SendVerificationMailResponse.from(value)));

    switch (result) {
      case Ok(:final value):
        {
          if (value.status == ApiStatus.failed) {
            final err = value.error.unwrap();
            return Err(
                MethodError(err.code.toString(), message: err.getMessage));
          }

          return Ok(value.data.unwrap());
        }
      case Err(:final value):
        {
          if (value is PostgrestException) {
            return Err(
                MethodError(value.code!, message: value.details.toString()));
          } else if (value is SocketException) {
            return const Err(MethodError("500", message: "Network Error"));
          } else {
            print(value);
            return const Err(MethodError("500"));
          }
        }
    }
  }

  @override
  Future<Result<LoginResponse, MethodError>> verifyEmail(
      String email, String code) async {
    final result = (await withResultAsync(() => client.functions.invoke(
            "scheduleme",
            method: HttpMethod.post,
            headers: {"rpc": "email-verification"},
            body: {"email": email})))
        .map((value) => ApiResponse.decodeResponseFromJson(value.data,
            data: (value) => LoginResponse.from(value)));

    switch (result) {
      case Ok(:final value):
        {
          if (value.status == ApiStatus.failed) {
            final err = value.error.unwrap();
            return Err(
                MethodError(err.code.toString(), message: err.getMessage));
          }

          return Ok(value.data.unwrap());
        }
      case Err(:final value):
        {
          if (value is PostgrestException) {
            return Err(
                MethodError(value.code!, message: value.details.toString()));
          } else if (value is SocketException) {
            return const Err(MethodError("500", message: "Network Error"));
          } else {
            print(value);
            return const Err(MethodError("500"));
          }
        }
    }
  }

  /// Appointment & Spaces
  @override
  Future<Result<GetAppointmentResponse, MethodError>> getAppointments(
      {String? purpose, String? status, DateTime? dateTime}) async {
    return Ok(GetAppointmentResponse(appointments: []));
  }

  @override
  Future<Result<GetAppointmentResponse, MethodError>> findAppointments(
      String keyword,
      {String? status}) async {
    return Ok(GetAppointmentResponse(appointments: []));
  }

  @override
  Future<Result<GetFormResponse, MethodError>> getAppointmentForm(
      String spaceId) async {
    return Ok(GetFormResponse(appointmentForms: []));
  }

  @override
  Future<Result<GenericResponse, MethodError>> setDefaultAppointmentForm(
      String spaceId, String formId) async {
    return Ok(GenericResponse());
  }
}
