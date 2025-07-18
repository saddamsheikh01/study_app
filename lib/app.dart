import 'package:flutter/material.dart';
import 'package:study/pages/login.dart';
import 'package:study/pages/notifications_page.dart';
import 'package:study/pages/onboarding/onboarding_page.dart';
import 'package:study/pages/profile/edit_profile.dart';
import 'package:study/pages/profile/profile_page.dart';
import 'package:study/pages/register.dart';
import 'first_run.dart';
import 'home/home_page.dart';
import 'pages/password_recovery.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF082030)),
        useMaterial3: true,
        fontFamily: 'InstrumentSans',

        // Disable ripple and highlight globally
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/password-recovery': (context) => const PassRecovery(),
        '/homescreen': (context) => const MyHomePage(title: "StudySwap"),
        '/notifications': (context) => const NotificationsPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(hasAppBar: true,),
        '/edit-profile': (context) => const EditProfile(),
      },
      home: LandingPage(),
    );
  }
}
