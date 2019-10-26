import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pushhealth/main.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageList = [
    PageModel(
      color: Colors.blueGrey,
      heroAssetPath: null,
      iconAssetPath: null,
      title: Text('Welcome!'),
      body: Text(
          'Welcome to Push Health, your new guide to becoming a better you!'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: FancyOnBoarding(
        doneButtonText: 'All Done!',
        showSkipButton: false,
        pageList: pageList,
        onDoneButtonPressed: () => Navigator.push(
            context,
            platformPageRoute(
              context: context,
              builder: (_) => MyHomePage(
                title: 'Home Page',
              ),
            )),
      ),
    );
  }
}
