import 'package:get/state_manager.dart';
import 'package:scheduleme/services/space/appointment/model.dart';

abstract class HomeState {
  static var searchBarFocused = false.obs;
  static var findAppointmentHistory = <Appointment>[].obs;
}
