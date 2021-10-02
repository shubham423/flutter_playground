import 'package:flutter/material.dart';
import 'package:flutter_playground/auth/shared/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaredReposPage extends ConsumerWidget {
  const StaredReposPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authNotifierProvider.notifier).signOut();
          },
          child: Text('Sign out'),
        ),
      ),
    );
  }
}
