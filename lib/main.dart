import 'package:flutter/material.dart';
import 'package:infinity_box_task/theme/app_theme.dart';
import 'package:infinity_box_task/utils/globals.dart';
import 'package:infinity_box_task/utils/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: Globals.navigatorKey,
      scaffoldMessengerKey: Globals.scaffoldMessengerKey,
      initialRoute: RouteGenerator.initialRoute,
    );
  }
}
