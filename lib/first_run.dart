import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'misc/resources.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  Future<bool> _checkFirstRun() => IsFirstRun.isFirstRun();

  Future<String> _getInitialRoute() async {
    // Check authentication
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return '/onboarding';

    // If authenticated, go to home
    return '/homescreen';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(snapshot.data!);
          });

          return Container(
            color: theme.colorScheme.surface,
            child: Center(
              child: Image.asset(R.imageOnboarding4, width: 128),
            ),
          );
        }
      },
    );
  }
}
