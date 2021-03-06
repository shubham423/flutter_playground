import 'package:dio/dio.dart';
import 'package:flutter_playground/core/infrastructure/network_exceptions.dart';
import 'package:flutter_playground/core/infrastructure/remote_response.dart';
import 'package:flutter_playground/github/core/infrastrucure/github_headers.dart';
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
    const token="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";
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

      if (response.statusCode == 304) {
        return RemoteResponse.notModified(
          maxPage: previousHeaders?.link?.maxPage ?? 0,
        );
      } else if (response.statusCode == 200) {
        final headers = GithubHeaders.parse(response);
        await _headersCache.saveHeaders(requestUri, headers);
        final convertedDate = (response.data as List<dynamic>)
            .map((e) => GithubRepoDTO.fromJson(e as Map<String, dynamic>))
            .toList();
        return RemoteResponse.withNewData(
          convertedDate,
          maxPage: previousHeaders?.link?.maxPage ?? 1,
        );
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return RemoteResponse.noConnection(
          maxPage: previousHeaders?.link?.maxPage ?? 0,
        );
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
