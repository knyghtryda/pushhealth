import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pushhealth/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dayGreeting() {
    TimeOfDay time = TimeOfDay.now();
    int hour = time.hour;
    if (hour >= 4 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }

  Color dayColor() {
    TimeOfDay time = TimeOfDay.now();
    int hour = time.hour;
    if (hour >= 4 && hour < 12) {
      return Colors.orange;
    } else if (hour >= 12 && hour < 17) {
      return Colors.yellow;
    } else if (hour >= 17 && hour < 21) {
      return Colors.lightBlue;
    } else {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HealthProvider>(context);
    var greeting = dayGreeting() ?? 'No Greeting!';
    return PlatformScaffold(
      iosContentPadding: true,
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: dayColor()),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat('MMMM').format(DateTime.now()),
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        DateTime.now().day.toString(),
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //Spacer(),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.tasks?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
