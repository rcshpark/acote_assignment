// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoDto _$RepoDtoFromJson(Map<String, dynamic> json) => RepoDto(
      title: json['name'] as String,
      subTitle: json['description'] as String?,
      starCount: (json['stargazers_count'] as num).toInt(),
      language: json['language'] as String?,
    );

Map<String, dynamic> _$RepoDtoToJson(RepoDto instance) => <String, dynamic>{
      'name': instance.title,
      'description': instance.subTitle,
      'stargazers_count': instance.starCount,
      'language': instance.language,
    };
