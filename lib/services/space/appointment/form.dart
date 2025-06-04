import 'package:option_result/option.dart';
import 'package:option_result/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';

part "form.g.dart";

@riverpod
class GetAppointmentForm extends _$GetAppointmentForm {
  @override
  AsyncValue<Option<GetFormResponse>> build() => const AsyncData(None());

  Future getAppointmentFormById(String spaceId, String formId) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 2));
    state = const AsyncData(None());
  }

  Future getAppointmentForms(String spaceId) async {
    state = const AsyncLoading();
    final result = await applicationMethod.getAppointmentForm(spaceId);
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
