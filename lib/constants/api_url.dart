abstract class ApiURL {
  static const base = "http://localhost:5800";
  static const loginProvider = "$base/login-provider";
  static const signup = "$base/auth/register";
  static const login = "$base/auth/login";
  static const emailVerification = "$base/email-verification";

  // spaces
  static const spaces = "$base/spaces";
  static String spaceWithId(String id) => "$spaces/$id";

// space-settings
  static String spaceSetting(String id) => "$spaces/$id/setting";

// space-security
  static String spaceMembers(String id) => "${spaceWithId(id)}/members";
  static String spaceMemberWithId(String id, String memberId) =>
      "${spaceMembers(id)}/$memberId";

  static String spaceRoles(String id) => "${spaceWithId(id)}/roles";
  static String spaceRoleWithId(String id, String roleId) =>
      "${spaceRoles(id)}/$roleId";

  // space-appointments
  static String spaceAppointments(String id) => "$spaceWithId(id)/appointments";
  static String spaceAppointmentsWithId(String id, String appointmentId) =>
      "${spaceAppointments(id)}/$appointmentId";

  // space-memo
  static String spaceMemos(String id) => "${spaceWithId(id)}/memos";
  static String spaceMemoWithId(String id, String memoId) =>
      "${spaceMemos(id)}/$memoId";

  // space-reminders
  static String spaceReminders(String id) => "${spaceWithId(id)}/memos";
  static String spaceRemindersWithId(String id, String reminderId) =>
      "${spaceReminders(id)}/$reminderId";
}
