import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "login")
  final String userName;
  @JsonKey(name: "avatar_url")
  final String avatarUrl;
  @JsonKey(name: "id")
  final int id;

  UserDto({required this.userName, required this.avatarUrl, required this.id});
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
