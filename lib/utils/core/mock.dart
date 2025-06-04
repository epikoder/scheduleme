import 'package:option_result/result.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
import 'package:uuid/v4.dart';

class MockMethod extends Method {
  @override
  Future initialize() async {
    //
  }

  @override
  Future<Result<AuthMethod, MethodError>> getAuthMethod(String email) async {
    return const Ok(AuthMethod.credentials);
  }

  @override
  Future<Result<SendVerificationMailResponse, MethodError>>
      sendVerificationToken(String email) async {
    return const Ok(SendVerificationMailResponse.success);
  }

  @override
  Future<Result<GenericResponse, MethodError>> signUpWithEmail(
      String email, String password) async {
    return Ok(GenericResponse());
  }

  @override
  Future<Result<LoginResponse, MethodError>> singInWithPassword(
      String email, String password) async {
    return Ok(LoginResponse.from({
      "user": {
        "id": const UuidV4().generate(),
        "email": email,
        "providers": [
          "credentials",
        ],
        "meta_data": {
          "full_name": "Acme Doe",
          "phone": {"code": 234, "phone": "9052222222"},
          "photo": "avatar.png",
        },
        "profiles": [
          {
            "id": const UuidV4().generate(),
            "full_name": "Acme Doe",
            "profile_type": "organisation",
            "phone": {"code": 234, "phone": "9052222222"},
            "photo": "avatar1.png",
            "space_id": const UuidV4().generate(),
          },
          {
            "id": const UuidV4().generate(),
            "full_name": "John Wick",
            "profile_type": "estate",
            "phone": {"code": 234, "phone": "9052255555"},
            "photo": "avatar2.png",
            "space_id": const UuidV4().generate(),
          },
        ]
      },
      "tokens": {
        "access_token": "ey....",
        "refresh_token": "ey....",
      }
    }));
  }

  @override
  Future<Result<LoginResponse, MethodError>> verifyEmail(
      String email, String code) async {
    return Ok(LoginResponse.from({
      "user": {
        "id": const UuidV4().generate(),
        "email": email,
        "providers": [
          "credentials",
        ],
        "meta_data": {
          "full_name": "Acme Doe",
          "phone": {"code": 234, "phone": "9052222222"},
          "photo": "avatar.png",
        },
        "profiles": [
          {
            "id": const UuidV4().generate(),
            "full_name": "Acme Doe",
            "profile_type": "organisation",
            "phone": {"code": 234, "phone": "9052222222"},
            "photo": "avatar1.png",
            "space_id": const UuidV4(),
          },
          {
            "id": const UuidV4().generate(),
            "full_name": "John Wick",
            "profile_type": "estate",
            "phone": {"code": 234, "phone": "9052255555"},
            "photo": "avatar2.png",
            "space_id": const UuidV4().generate(),
          },
        ]
      },
      "tokens": {
        "access_token": "ey....",
        "refresh_token": "ey....",
      }
    }));
  }

  @override
  Future<Result<GetAppointmentResponse, MethodError>> getAppointments(
      {String? purpose, String? status, DateTime? dateTime}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Ok(GetAppointmentResponse(appointments: [
      Appointment.fromJson({
        "id": const UuidV4().generate(),
        "appointment_type": AppointmentType.meeting.string,
        "title": "Bell Meet",
        "duration": 120,
        "tag": {
          "id": "sa",
          "name": "Con",
          "color": "ffe3ff",
        },
        "status": status ?? AppointmentStatus.scheduled.string,
        "host": {
          "host_id": const UuidV4().generate(),
          "host_name": "Eric",
        },
        "participants": [
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
        ],
        "date_time": DateTime.now().toIso8601String(),
      }),
    ]));
  }

  @override
  Future<Result<GetAppointmentResponse, MethodError>> findAppointments(
      String keyword,
      {String? status}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Ok(GetAppointmentResponse(appointments: [
      Appointment.fromJson({
        "id": const UuidV4().generate(),
        "appointment_type": AppointmentType.meeting.string,
        "title": "Bell Meet",
        "duration": 120,
        "tag": {
          "id": "sa",
          "name": "Con",
          "color": "ffe3ff",
        },
        "status": status ?? AppointmentStatus.scheduled.string,
        "host": {
          "host_id": const UuidV4().generate(),
          "host_name": "Eric",
        },
        "participants": [
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
          {
            "id": const UuidV4().generate(),
            "name": "No Name",
            "email": "efedua@mail.com",
            "photo": "avatar.png",
          },
        ],
        "date_time": DateTime.now().toIso8601String(),
      }),
    ]));
  }

  var appointmentForm = <AppointmentForm>[
    AppointmentForm(
      id: "h_id",
      name: "Default Hospital form",
      dateTime: DateTime.now(),
      isDefault: true,
    ),
    AppointmentForm(
        id: "e_id", name: "Default Estate form", dateTime: DateTime.now()),
  ];

  @override
  Future<Result<GetFormResponse, MethodError>> getAppointmentForm(
      String spaceId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Ok(GetFormResponse(appointmentForms: appointmentForm));
  }

  @override
  Future<Result<GenericResponse, MethodError>> setDefaultAppointmentForm(
      String spaceId, String formId) async {
    appointmentForm.sort(
        (a, b) => (a.id == formId ? 1 : 0).compareTo(b.id == formId ? 1 : 0));
    appointmentForm.forEach((value) => print(value.id));
    return Ok(GenericResponse());
  }
}
