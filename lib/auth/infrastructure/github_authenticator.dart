import 'package:flutter_playground/auth/infrastructure/credential_storage/credential_storage.dart';
import 'package:oauth2/oauth2.dart';

class GithubAuthenticator {
  final CredentialsStorage _credentialsStorage;

  GithubAuthenticator(this._credentialsStorage);

  Future<Credentials?> getSignedInCredentials() async {
    final storedCredentials = await _credentialsStorage.read();
    return storedCredentials;
  }
}
