import 'package:flutter_test/flutter_test.dart' as test;
import 'package:option_result/option.dart';
import 'package:scheduleme/services/space/appointment/model.dart';

void main() {
  test.test('Test Deserialize appointment', () {
    final appointmentData = <String, dynamic>{
      "_id": "5f52c805df41c9df948e6785",
      "appointment_type": "meeting",
      "title": "Standup Meeting",
      "duration": 30,
      "tag": {
        "id": "developers-meeting",
        "name": "Project Discussion",
        "color": "#fff"
      },
      "status": "scheduled",
      "host": {"host_id": "5f52c805df41c9df948e6785", "host_name": "John Doe"},
      "participants": [
        {
          "participant_id": "5f52c805df41c9df948e6785",
          "name": "Jane Smith",
          "email": "jane@example.com"
        },
        {
          "participant_id": "5f52c805df41c9df948e6785",
          "name": "Alex Johnson",
          "email": "alex@example.com"
        }
      ],
      "date_time": "2025-04-10T10:00:00Z",
      "location": "Conference Room A",
      "notes": "Discuss Q2 project roadmap."
    };

    test.expect(Appointment.fromJson(appointmentData).id.toString(),
        "5f52c805df41c9df948e6785");
    final appointmentDataNoLocation = <String, dynamic>{
      "_id": "5f52c805df41c9df948e6785",
      "appointment_type": "meeting",
      "title": "Standup Meeting",
      "duration": 30,
      "tag": {
        "id": "developers-meeting",
        "name": "Project Discussion",
        "color": "#fff"
      },
      "status": "scheduled",
      "host": {"host_id": "5f52c805df41c9df948e6785", "host_name": "John Doe"},
      "participants": [
        {
          "participant_id": "5f52c805df41c9df948e6785",
          "name": "Jane Smith",
          "email": "jane@example.com"
        },
        {
          "participant_id": "5f52c805df41c9df948e6785",
          "name": "Alex Johnson",
          "email": "alex@example.com"
        }
      ],
      "date_time": "2025-04-10T10:00:00Z",
      "location": null,
      "notes": "Discuss Q2 project roadmap."
    };
    test.expect(
        Appointment.fromJson(appointmentDataNoLocation).location, const None());
  });
}
