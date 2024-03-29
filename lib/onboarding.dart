import 'package:dropdownfield/dropdownfield.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:pushhealth/home.dart';
import 'package:pushhealth/provider.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  pages(HealthProvider provider) {
    return [
      PageViewModel(
        image: Center(
          child: SvgPicture.asset(
            'assets/onboarding/intro.svg',
            semanticsLabel: 'Intro',
          ),
        ),
        title: 'Welcome!',
        body: 'Say hi to Glu, your new buddy to becoming a better you!',
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
                    ios: (_) =>
                        CupertinoTextFieldData(placeholder: 'First Name'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  PlatformTextField(
                    android: (_) => MaterialTextFieldData(
                        decoration: InputDecoration(labelText: 'Last Name')),
                    ios: (_) =>
                        CupertinoTextFieldData(placeholder: 'Last Name'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  PlatformTextField(
                    android: (_) => MaterialTextFieldData(
                        decoration: InputDecoration(labelText: 'Zip Code')),
                    ios: (_) => CupertinoTextFieldData(placeholder: 'Zip Code'),
                    onChanged: (zip) {
                      provider.zipCode = int.parse(zip);
                    },
                    onSubmitted: (zip) {
                      provider.zipCode = int.parse(zip);
                    },
                    keyboardType: TextInputType.number,
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
              padding: EdgeInsets.all(10),
              children: Activity.values
                  .map((activity) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: FlatButton(
                            onPressed: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: activity == Activity.None
                                          ? [
                                              Icon(Icons
                                                  .airline_seat_recline_normal)
                                            ]
                                          : [
                                              for (var i = 0;
                                                  i <
                                                      Activity.values
                                                          .indexOf(activity);
                                                  i++)
                                                Icon(Icons.directions_run)
                                            ]),
                                ),
                                Text(
                                  EnumToString.parse(activity),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList())),
      PageViewModel(
        title: 'Likes',
        bodyWidget: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: Likes.values
              .map((like) => SizedBox(
                    width: 50,
                    height: 50,
                    child: FlatButton(
                      onPressed: () => provider.toggleLike(like),
                      color: provider.likes?.contains(like) ?? false
                          ? Colors.blue
                          : Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            likes[like],
                            size: 60,
                          ),
                          Text(
                            EnumToString.parse(like),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      PageViewModel(
          title: 'Communication Preference',
          bodyWidget: Column(
            children: <Widget>[
              Text('How would you like me to communicate with you?'),
              DropDownField(
                required: true,
                labelText: 'Talk to me through...',
                items: Comm.values
                    .map((comm) => EnumToString.parse(comm))
                    .toList(),
                onValueChanged: (item) {},
              )
            ],
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HealthProvider>(context);
    return PlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: IntroductionScreen(
          pages: pages(provider),
          onDone: () async {
            //provider.getLatLongByZip(provider.zipCode);
            //provider.generateTasks();
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return Home();
            }));
          },
          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          next:
              const Text('Next', style: TextStyle(fontWeight: FontWeight.w600)),
          showSkipButton: false,
          showNextButton: true,
        ),
      ),
    );
  }
}
