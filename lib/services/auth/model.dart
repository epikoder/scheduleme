import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class User {
  User({
    required this.email,
    this.profile,
    this.profiles = const [],
  });
  String email;

  List<Profile> profiles;
  @JsonKey(name: "meta_data")
  Profile? profile;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Profile {
  Profile({
    this.fullName,
    this.phone,
  });
  @JsonKey(name: "full_name")
  String? fullName;
  Phone? phone;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Phone {
  Phone({
    required this.code,
    required this.phone,
  });
  int code;
  String phone;

  Future<void> updatePhone(int code, String phone) async {
    this.code = code;
    this.phone = phone;
  }

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
