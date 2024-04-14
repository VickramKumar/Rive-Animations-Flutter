import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive_animations/screens/login_screen.dart';
import 'package:rive_animations/provider/home_screen_provider.dart';
import 'package:rive_animations/provider/login_screen_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
      ],
      builder: (context, child) {
        return Sizer(
          builder: (context, orientation, device) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.green,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              ),
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
