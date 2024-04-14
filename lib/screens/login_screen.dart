// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:math';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive_animations/constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rive_animations/common/custom_text_field.dart';
import 'package:rive_animations/provider/login_screen_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginScreenProvider provider =
        Provider.of<LoginScreenProvider>(context, listen: false);

    provider.initializeArtBoard();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 100.h, width: 100.w),
              for (var a = 0; a < 100; a++)
                Positioned(
                  top: Random().nextInt(100).toDouble().h,
                  left: Random().nextInt(100).toDouble().w,
                  child: Center(
                    child: Transform.rotate(
                      angle: Random().nextInt(360).toDouble(),
                      child: Icon(
                        iconsList[Random().nextInt(14)],
                        color: Color.fromARGB(
                          Random().nextInt(250),
                          Random().nextInt(250),
                          Random().nextInt(250),
                          Random().nextInt(250),
                        ),
                        size: (Random().nextInt(24).toDouble()).sp,
                      ),
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13.h),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        'Log In To Get Started!',
                        speed: const Duration(milliseconds: 500),
                        textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Center(
                    child: Selector<LoginScreenProvider, bool>(
                      selector: (context, selector) => selector.unUsedVariable,
                      builder: (context, value, child) {
                        if (provider.riveArtBoard != null) {
                          return SizedBox(
                            height: 30.h,
                            width: 100.w,
                            child: Rive(
                              artboard: provider.riveArtBoard!,
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Enter Email',
                    icon: Icons.alternate_email,
                    controller: provider.emailController,
                    onTap: () => provider.lookOnTheTextField(),
                    onChanged: (value) {
                      provider.moveEyeBalls(value);
                    },
                  ),
                  SizedBox(height: 2.5.h),
                  CustomTextField(
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                    obscureText: true,
                    controller: provider.passwordController,
                    onTap: () => provider.handsOnTheEyes(),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black54.withOpacity(0.5),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  GestureDetector(
                    onTap: () => provider.login(context),
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4EB048),
                        borderRadius: BorderRadius.circular(7.sp),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
