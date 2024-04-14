import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class MyNotifications {
  static flushbar({
    IconData? icon,
    required BuildContext context,
    required String message,
  }) async {
    await Flushbar(
      positionOffset: 3.h,
      flushbarPosition: FlushbarPosition.TOP,
      blockBackgroundInteraction: true,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      leftBarIndicatorColor: Colors.white,
      icon: Icon(icon ?? Icons.error_outline, color: Colors.white),
      backgroundColor: Colors.white.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).show(context);
  }
}
