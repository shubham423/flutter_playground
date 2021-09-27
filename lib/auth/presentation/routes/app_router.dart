import 'package:auto_route/annotations.dart';
import 'package:flutter_playground/auth/presentation/authorization_page.dart';
import 'package:flutter_playground/auth/presentation/sign_in_page.dart';
import 'package:flutter_playground/splash/presentation/splash_page.dart';
import 'package:flutter_playground/starred_repos/starred_repos_page.dart';

// ignore: require_trailing_commas
@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: AuthorizationPage),
    MaterialRoute(page: StaredReposPage),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
