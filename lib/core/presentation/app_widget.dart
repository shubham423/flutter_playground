import 'package:flutter/material.dart';
import 'package:flutter_playground/auth/presentation/routes/app_router.gr.dart';

class AppWidget extends StatelessWidget {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Repo Viewer',
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
