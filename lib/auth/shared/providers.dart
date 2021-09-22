import 'package:dio/dio.dart';
import 'package:flutter_playground/auth/application/auth_notifier.dart';
import 'package:flutter_playground/auth/infrastructure/credential_storage/secure_credentials_storage.dart';
import 'package:flutter_playground/auth/infrastructure/github_authenticator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final flutterSecureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);
final credentialsStorageProvider = Provider(
  (ref) => SecureCredentialsStorage(
    ref.watch(flutterSecureStorageProvider),
  ),
);

final dioProvider = Provider(
  (ref) => Dio(),
);
final githubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialsStorageProvider),
    ref.watch(dioProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch(githubAuthenticatorProvider),
  ),
);
