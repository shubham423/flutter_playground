import 'package:dio/dio.dart';
import 'package:flutter_playground/core/infrastructure/network_exceptions.dart';
import 'package:flutter_playground/core/infrastructure/remote_response.dart';
import 'package:flutter_playground/github/core/infrastrucure/github_headers_cache.dart';
import 'package:flutter_playground/github/core/infrastrucure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  StarredReposRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
    int page,
  ) async {
    const token = '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';
    const accept = 'application/vnd.github.v3.html+json';
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {'page': '$page'},
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);
    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'Authorization': 'bearer $token',
            'Accept': accept,
            'If-None-Match': previousHeaders?.etag ?? '',
          },
        ),
      );
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
