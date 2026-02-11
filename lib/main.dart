import 'package:evently_assignment/providers/home_provider.dart';
import 'package:evently_assignment/providers/theme_provider.dart';
import 'package:evently_assignment/screens/home_screen.dart';
import 'package:evently_assignment/screens/login_screen.dart';
import 'package:evently_assignment/screens/onboarding_screen.dart';
import 'package:evently_assignment/ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),

      child: ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          routes: {
            "LoginScreen": (context) => LoginScreen(),
            "HomeScreen": (context) => HomeScreen(),
          },

          home: OnboardingScreen(),
        );
      },
    );
  }
}
