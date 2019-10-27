import 'package:dropdownfield/dropdownfield.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:pushhealth/main.dart';
import 'package:pushhealth/provider.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pages = [
    PageViewModel(
      image: Center(
        child: SvgPicture.asset(
          'assets/onboarding/intro.svg',
          semanticsLabel: 'Intro',
        ),
      ),
      title: 'Welcome!',
      body: 'Welcome to Push Health, your new guide to becoming a better you!',
    ),
    PageViewModel(
      title: 'Personal Information',
      bodyWidget: Column(
        children: <Widget>[
          Form(
            child: Column(
              children: <Widget>[
                PlatformTextField(
                  autofocus: true,
                  android: (_) => MaterialTextFieldData(
                      decoration: InputDecoration(labelText: 'First Name')),
                  ios: (_) => CupertinoTextFieldData(placeholder: 'First Name'),
                  textCapitalization: TextCapitalization.words,
                ),
                PlatformTextField(
                  android: (_) => MaterialTextFieldData(
                      decoration: InputDecoration(labelText: 'Last Name')),
                  ios: (_) => CupertinoTextFieldData(placeholder: 'Last Name'),
                  textCapitalization: TextCapitalization.words,
                ),
                PlatformTextField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    android: (_) => MaterialTextFieldData(
                        decoration: InputDecoration(labelText: 'Age')),
                    ios: (_) => CupertinoTextFieldData(placeholder: 'Age')),
                DropDownField(
                  items: Race.values
                      .map((race) => EnumToString.parse(race))
                      .toList(),
                  labelText: 'Race',
                  required: true,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    PageViewModel(
        title: 'Activity Level',
        bodyWidget: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: Activity.values
                .map((activity) => SizedBox(
                      width: 100,
                      height: 100,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0;
                                      i < Activity.values.indexOf(activity);
                                      i++)
                                    Icon(Icons.directions_run)
                                ]),
                            Text(EnumToString.parse(activity))
                          ],
                        ),
                      ),
                    ))
                .toList())),
    PageViewModel(title: 'Likes', bodyWidget: Container()),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HealthProvider>(context);
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
