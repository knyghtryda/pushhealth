import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pushhealth/main.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pages = [
    PageViewModel(
      title: 'Welcome!',
      body: 'Welcome to Push Health, your new guide to becoming a better you!',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () => Navigator.push(
          context,
          platformPageRoute(
              context: context,
              builder: (_) => MyHomePage(
                    title: 'Home Page',
                  ))),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      showSkipButton: false,
    );
  }
}
