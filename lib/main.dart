import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dreamflow/screens/splash_screen.dart';
import 'package:dreamflow/theme/theme_constants.dart';
import 'package:dreamflow/theme/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _themeController,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeController.themeMode,
        builder: (context, themeMode, _) {
          return MaterialApp(
            title: 'DreamFlow',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }
}