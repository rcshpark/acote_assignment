// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      userName: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'login': instance.userName,
      'avatar_url': instance.avatarUrl,
      'id': instance.id,
    };
