import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_flutter/constants/my_colors.dart';
import 'package:bloc_flutter/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  buildTitle(context) {
    return Center(
      child: SizedBox(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: GoogleFonts.lobster(fontSize: 30.0, color: Colors.white),
            child: AnimatedTextKit(
              onFinished: () {
                Navigator.pushNamed(context, homeScreen);
              },
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText('Dear user'),
                TypewriterAnimatedText('This app Developed'),
                TypewriterAnimatedText('By'),
                TypewriterAnimatedText('Clark Joseph'),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.red,
      body: Center(
        child: buildTitle(context),
      ),
    );
  }
}
