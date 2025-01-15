part of 'main.dart';

void ensureMockServerWhenTesting() {
  Client.instance.registerMock(
    ApiURL.login.pathOnly,
    HttpMethod.get,
    (request) async {
      await Future.delayed(const Duration(seconds: 1));
      final email = request.url.queryParameters["email"];
      if (email == null || email.isEmpty || !email.contains("@")) {
        return Future.value(
            http.Response("""{"status": "success", "data": "none"}""", 200));
      }
      if (email == "@google") {
        return Future.value(
            http.Response("""{"status": "success", "data": "google"}""", 200));
      }

      return Future.value(http.Response(
          """{"status": "success", "data": "credentials"}""", 200));
    },
  );

  Client.instance.registerMock(
    ApiURL.login.pathOnly,
    HttpMethod.post,
    (request) async {
      logger.d(
        "Got request ${request.url.path} ${request.bodyFields}",
      );
      await Future.delayed(const Duration(seconds: 1));
      final credentials = request.bodyFields;
      return Future.value(http.Response(
          jsonEncode({
            "status": "success",
            "data": {
              "user": {
                "email": "${credentials["email"]}",
                "providers": ["credentials", "google"],
                "meta_data": {
                  "full_name": "Acme Doe",
                  "phone": {"code": 234, "phone": "9052222222"},
                  "photo": "/avatar.png",
                },
                "profiles": [
                  {
                    "profile_type": "organisation",
                    "photo": "/avatar1.png",
                    "space_id": "space_id_2"
                  },
                  {
                    "full_name": "John Wick",
                    "profile_type": "estate",
                    "phone": {"code": 234, "phone": "9052255555"},
                    "photo": "/avatar2.png",
                    "space_id": "space_id_2"
                  },
                ]
              },
              "tokens": {"access_token": "ey....", "refresh_token": "ey...."}
            }
          }),
          200));
    },
  );

  Client.instance.registerMock(ApiURL.spaceWithId("space_id"), HttpMethod.get,
      (request) {
    const spaceId = "space_id";
    if (request.url.pathSegments.last == spaceId) {
      return Future.value(http.Response(
          jsonEncode({
            "status": "success",
            "error": {
              "code": 404,
              "message": "NotFound",
            }
          }),
          200));
    }

    return Future.value(http.Response(
        jsonEncode({
          "status": "success",
          "data": {
            "_id": "space_id",
            "_user_id": "user_id",
            "space_type": "estate",
            "members": [
              {
                "_id": "member_id_1",
                "role": "member",
              },
              {
                "_id": "member_id_2",
                "role": "member",
              },
              {
                "_id": "member_id_3",
                "role": "gate_security",
              },
            ],
            "roles": {
              "owner": [],
              "admin": [],
              "gate_security": [
                "members:write",
                "members:read",
                "appointment:confirmation",
              ],
            },
            "form": {
              "create:appointment": [
                {
                  "name": "full_name",
                  "field_type": "text",
                  "placeholder": "Acme Joe",
                  "title": {
                    "text": "Full name",
                    "is_required": true,
                  },
                },
              ]
            }
          }
        }),
        200));
  });
}

final formBuilderJson = {
  "text_input": {
    "name": "input_name",
    "field_type": ["text", "checkbox"],
    "placeholder": "placeholder",
    "title": {
      "text": "input title",
      "is_required": "boolean",
    },
    "input_type": ["phone", "email", "password"],
  },
};

extension on String {
  String get pathOnly => replaceFirst(ApiURL.base, "");
}
