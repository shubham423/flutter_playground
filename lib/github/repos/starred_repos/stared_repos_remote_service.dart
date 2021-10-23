
import 'package:dio/dio.dart';
import 'package:flutter_playground/core/infrastructure/remote_response.dart';
import 'package:flutter_playground/github/core/infrastrucure/github_repo_dto.dart';

class StarredReposRemoteService{
  final Dio _dio;

  StarredReposRemoteService(this._dio);
  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
    int page,
  ) async {

  }
}
