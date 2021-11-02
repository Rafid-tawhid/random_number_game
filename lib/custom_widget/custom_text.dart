import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,

      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 35.0,
          color: Colors.red,
          fontFamily: 'Cursive',
          letterSpacing: 2
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            ScaleAnimatedText('Congratulations'),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 1000),
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );;
  }
}
