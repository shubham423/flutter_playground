
import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/domain/fresh.dart';
import 'package:flutter_playground/core/infrastructure/network_exceptions.dart';
import 'package:flutter_playground/github/core/domain/github_failure.dart';
import 'package:flutter_playground/github/core/domain/github_repo.dart';
import 'package:flutter_playground/github/core/infrastrucure/github_repo_dto.dart';
import 'package:flutter_playground/github/repos/starred_repos/infrastructure/stared_repos_remote_service.dart';
import 'package:flutter_playground/github/repos/starred_repos/infrastructure/starred_repos_local_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;
  final StarredReposLocalService _localService;

  StarredReposRepository(
    this._remoteService,
    this._localService,
  );

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
      int page) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);
      return right(
        await remotePageItems.when(
          // TODO: local service
          noConnection: (maxPage) async => Fresh.no(
            await _localService.getPage(page).then(
                  (_) => _.toDomain(),
                ),
            isNextPageAvailable: page < maxPage,
          ),
          notModified: (maxPage) async => Fresh.yes(
            await _localService.getPage(page).then(
                  (_) => _.toDomain(),
                ),
            isNextPageAvailable: page < maxPage,
          ),
          withNewData: (data, maxPage) async {
            await _localService.upsertPage(data, page);
            return Fresh.yes(
              data.toDomain(),
              isNextPageAvailable: page < maxPage,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}

extension DTOListTODomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
