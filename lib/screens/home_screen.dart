import 'dart:math';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive_animations/constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rive_animations/provider/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4EB048),
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(width: 15.w),
            Text(
              'Rive Animations',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                RotateAnimatedText(
                  'wonders',
                  duration: const Duration(seconds: 2),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RotateAnimatedText(
                  'bring',
                  duration: const Duration(seconds: 2),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RotateAnimatedText(
                  'smiles',
                  duration: const Duration(seconds: 2),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RotateAnimatedText(
                  'to your',
                  duration: const Duration(seconds: 2),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RotateAnimatedText(
                  'day',
                  duration: const Duration(seconds: 2),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
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
          Selector<HomeScreenProvider, bool>(
            selector: (context, selector) => selector.showBox,
            builder: (context, value, child) {
              if (provider.showBox) {
                return Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Marquee(
                    text:
                        'Experience the excitement by tapping on the Box to unveil your incredible surprise Gift!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    blankSpace: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                );
              } else {
                return const Center();
              }
            },
          ),
          SizedBox(
            height: 100.h,
            width: 100.h,
            child: Selector<HomeScreenProvider, bool>(
              selector: (context, selector) => selector.showBox,
              builder: (context, value, child) {
                if (value) {
                  return Transform.scale(
                    scale: 0.35,
                    child: InkWell(
                      onTap: () {
                        if (Random().nextBool()) {
                          provider.initializeCongratulationsArtBoard();
                        } else {
                          provider.initializeCharacterAnimationArtBoard();
                        }
                      },
                      child: const RiveAnimation.asset('assets/gift.riv'),
                    ),
                  );
                } else {
                  return Rive(artboard: provider.riveArtBoard!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
