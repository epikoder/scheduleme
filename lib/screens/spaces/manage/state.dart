import 'package:get/get.dart';
import 'package:scheduleme/components/form_builder/form_builder_creator.dart';
import 'package:scheduleme/services/space/appointment/model.dart';

abstract class AppointmentFormState {
  static final fields = <CreatorFieldInput>[].obs;
  static final formJson = <Map<String, dynamic>>[].obs;

  static final appointmentForms = <AppointmentForm>[].obs;
}
