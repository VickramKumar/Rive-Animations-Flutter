import 'dart:async';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenProvider extends ChangeNotifier {
  bool showBox = true;

  bool unUsedVariable = true;

  Artboard? riveArtBoard;

  SMITrigger? trigExplosion;
  SMITrigger? trigReset;

  SMITrigger? characterMiddleL;

  void initializeCharacterAnimationArtBoard() {
    rootBundle.load('assets/character_animation.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;

        final controller = StateMachineController.fromArtboard(
          artBoard,
          'Character Animation',
        );

        if (controller != null) {
          artBoard.addController(controller);

          for (var element in controller.inputs) {
            if (element.name == 'Character_Middle_l') {
              characterMiddleL = element as SMITrigger;
            }
          }

          riveArtBoard = artBoard;

          showBox = false;
          notifyListeners();
        }

        Timer.periodic(
          const Duration(seconds: 15),
          (timer) {
            characterMiddleL!.fire();
            timer.cancel();
          },
        );

        Timer.periodic(
          const Duration(seconds: 25),
          (timer) {
            showBox = true;
            notifyListeners();

            timer.cancel();
          },
        );
      },
    );
  }

  void initializeCongratulationsArtBoard() {
    rootBundle.load('assets/congratulations.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;

        final controller =
            StateMachineController.fromArtboard(artBoard, 'Congratulations');

        showBox = false;
        notifyListeners();

        if (controller != null) {
          artBoard.addController(controller);

          for (var element in controller.inputs) {
            if (element.name == 'Trigger explosion') {
              trigExplosion = element as SMITrigger;
            } else if (element.name == 'Reset') {
              trigReset = element as SMITrigger;
            }
          }

          riveArtBoard = artBoard;

          Timer.periodic(
            const Duration(seconds: 2),
            (timer) {
              trigExplosion!.fire();
              timer.cancel();
            },
          );

          Timer.periodic(
            const Duration(seconds: 4),
            (timer) {
              trigReset!.fire();
              timer.cancel();
            },
          );

          Timer.periodic(
            const Duration(seconds: 6),
            (timer) {
              trigExplosion!.fire();
              timer.cancel();
            },
          );

          Timer.periodic(
            const Duration(seconds: 8),
            (timer) {
              trigReset!.fire();
              timer.cancel();

              showBox = true;
              notifyListeners();
            },
          );
        }
      },
    );
  }
}
