class RepoModel {
  final String title;
  final String? subTitle;
  final int starCount;
  final String? language;

  RepoModel(
      {required this.title,
      required this.subTitle,
      required this.starCount,
      required this.language});
}
