import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class UsersModel {
  String name;
  String address;
  String avatar;

  UsersModel({required this.name, required this.address, required this.avatar});

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
