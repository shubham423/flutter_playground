import 'dart:ffi';

import 'package:oauth2/oauth2.dart';

abstract class CredentialsStorage {
  Future<Credentials?> read();
  Future<Void> save(Credentials credentials);
  Future<Void> clear();
}
