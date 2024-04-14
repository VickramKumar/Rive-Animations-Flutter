// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive_animations/screens/loading_screen.dart';
import 'package:rive_animations/notifications/my_notifications.dart';

class LoginScreenProvider extends ChangeNotifier {
  bool loading = false;

  bool obscureText = true;

  bool unUsedVariable = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SMIBool? isHandsUp;
  SMIBool? isChecking;
  SMITrigger? trigFail;
  SMITrigger? trigSuccess;
  SMINumber? numLook;

  Artboard? riveArtBoard;

  clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);

    unUsedVariable = !unUsedVariable;
    notifyListeners();
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);

    unUsedVariable = !unUsedVariable;
    notifyListeners();
  }

  void moveEyeBalls(value) {
    numLook?.change(value.length.toDouble());

    unUsedVariable = !unUsedVariable;
    notifyListeners();
  }

  void initializeArtBoard() {
    rootBundle.load('assets/animated_login_character.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;

        final controller =
            StateMachineController.fromArtboard(artBoard, 'Login Machine');

        if (controller != null) {
          artBoard.addController(controller);

          for (var element in controller.inputs) {
            if (element.name == 'isChecking') {
              isChecking = element as SMIBool;
            } else if (element.name == 'isHandsUp') {
              isHandsUp = element as SMIBool;
            } else if (element.name == 'trigSuccess') {
              trigSuccess = element as SMITrigger;
            } else if (element.name == 'trigFail') {
              trigFail = element as SMITrigger;
            } else if (element.name == 'numLook') {
              numLook = element as SMINumber;
            }
          }

          riveArtBoard = artBoard;

          unUsedVariable = !unUsedVariable;
          notifyListeners();
        }
      },
    );
  }

  void login(context) async {
    isChecking!.change(false);
    isHandsUp!.change(false);

    unUsedVariable = !unUsedVariable;
    notifyListeners();

    if (!emailController.text.contains('@gmail.com') &&
        passwordController.text.isEmpty) {
      MyNotifications.flushbar(
        context: context,
        message:
            'The Email should contain \'@gmail.com\' and Password should not Empty!',
      );
      trigFail!.fire();
    } else if (!emailController.text.contains('@gmail.com')) {
      MyNotifications.flushbar(
        context: context,
        message: 'The Email should contain \'@gmail.com\'',
      );

      trigFail!.fire();
    } else if (passwordController.text.isEmpty) {
      MyNotifications.flushbar(
        context: context,
        message: 'The Password should not Empty!',
      );

      trigFail!.fire();
    } else {
      MyNotifications.flushbar(
        context: context,
        message: 'You\'ve Logged-In successfuly.',
        icon: Icons.emoji_emotions,
      );

      numLook!.change(0);
      isChecking!.change(false);
      isHandsUp!.change(false);

      trigSuccess!.fire();

      unUsedVariable = !unUsedVariable;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 5));

      Get.offAll(() => const LoadingScreen());
    }

    unUsedVariable = !unUsedVariable;
    notifyListeners();
  }
}
