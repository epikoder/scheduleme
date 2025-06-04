import 'package:option_result/option_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
part "appointment.g.dart";

@riverpod
class GetAppointment extends _$GetAppointment {
  @override
  AsyncValue<Option<GetAppointmentResponse>> build() =>
      const AsyncValue.data(None());

  Future<void> getAppointment(
      {String? purpose, AppointmentStatus? status, DateTime? dateTime}) async {
    state = const AsyncValue.loading();

    final result = await applicationMethod.getAppointments(
        purpose: purpose, status: status?.string);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        state = AsyncValue.error(value, StackTrace.empty);
    }
  }
}

@riverpod
class FindAppointment extends _$FindAppointment {
  @override
  AsyncValue<Option<GetAppointmentResponse>> build() =>
      const AsyncValue.data(None());

  Future<void> findAppointment(
    String keyword, {
    AppointmentStatus? status,
  }) async {
    state = const AsyncValue.loading();

    final result = await applicationMethod.findAppointments(keyword,
        status: status?.string);
    switch (result) {
      case Ok(:final value):
        {
          state = AsyncValue.data(Some(value));
        }
      case Err(:final value):
        state = AsyncValue.error(value, StackTrace.empty);
    }
  }
}
