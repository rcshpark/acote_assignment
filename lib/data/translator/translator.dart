import 'package:acote_assignment/data/dto/repo_dto.dart';
import 'package:acote_assignment/data/dto/user_dto.dart';
import 'package:acote_assignment/data/exception/translate_exception.dart';
import 'package:acote_assignment/domain/model/data_state_model.dart';
import 'package:acote_assignment/domain/model/repo_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:flutter/foundation.dart';

class Translator {
  static final Translator _singleton = Translator._internal();

  Translator._internal();

  factory Translator() => _singleton;

  Future<DataState<List<UserModel>>> transalateUserInfo(
    List<UserDto> userInfo,
  ) {
    try {
      return compute(
        (List<UserDto> userInfo) {
          var translated = userInfo
              .map((userInfo) => UserModel(
                    userName: userInfo.userName,
                    avatarUrl: userInfo.avatarUrl,
                    id: userInfo.id,
                  ))
              .toList();

          return DataState.success(
            translated,
          );
        },
        userInfo,
      );
    } catch (error) {
      throw TranslateException(error.toString());
    }
  }

  Future<DataState<List<RepoModel>>> transalateRepoInfo(
    List<RepoDto> repoInfo,
  ) {
    try {
      return compute(
        (List<RepoDto> repoInfo) {
          var translated = repoInfo
              .map((repoInfo) => RepoModel(
                  title: repoInfo.title,
                  subTitle: repoInfo.subTitle,
                  starCount: repoInfo.starCount,
                  language: repoInfo.language))
              .toList();

          return DataState.success(
            translated,
          );
        },
        repoInfo,
      );
    } catch (error) {
      throw TranslateException(error.toString());
    }
  }
}
