import 'package:freezed_annotation/freezed_annotation.dart';
part 'repo_dto.g.dart';

@JsonSerializable()
class RepoDto {
  @JsonKey(name: "name")
  final String title;
  @JsonKey(name: "description")
  final String? subTitle;
  @JsonKey(name: "stargazers_count")
  final int starCount;
  @JsonKey(name: "language")
  final String? language;

  RepoDto(
      {required this.title,
      required this.subTitle,
      required this.starCount,
      required this.language});
  factory RepoDto.fromJson(Map<String, dynamic> json) =>
      _$RepoDtoFromJson(json);
}
