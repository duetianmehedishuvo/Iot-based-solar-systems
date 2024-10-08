import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/helper/message_dao.dart';
import 'package:women_safety/screen/astromy_day_screen.dart';
import 'package:women_safety/screen/planet_screen.dart';
import 'package:women_safety/util/helper.dart';
import 'package:women_safety/util/size.util.dart';
import 'package:women_safety/util/theme/app_colors.dart';
import 'package:women_safety/util/theme/text.styles.dart';
import 'package:women_safety/widgets/custom_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: spaceZero,
          title: Text('SolOptima', style: sfProStyle400Regular.copyWith(fontSize: 14, color: Colors.white)),
          centerTitle: true,
          backgroundColor: colorPrimary),
      body: StreamBuilder(
          stream: MessageDao.messagesRef.onValue,
          builder: (c, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            bool status = int.parse(snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(0).value.toString()) == 1;
            bool fanStatus = int.parse(snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(3).value.toString()) == 1;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Padding(padding: const EdgeInsets.all(8.0), child: Lottie.asset('assets/raw/solar_home.json')),
                  const SizedBox(height: 10),
                  eachRow("Battery-Life", '${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(2).value.toString()} %'),
                  eachRow(
                    "Light Control",
                    status ? "ON" : "OFF",
                    widget: Container(
                      height: 18,
                      width: 20,
                      alignment: Alignment.centerRight,
                      child: Switch(
                        onChanged: (bool value) {
                          MessageDao.messagesRef.ref.child("SENSOR_DATA").update({"light_status": status ? "0" : "1"});
                        },
                        value: status,
                        activeColor: Colors.white,
                        activeTrackColor: colorPrimary,
                      ),
                    ),
                  ),
                  eachRow(
                    "Fan Control",
                    !fanStatus ? "ON" : "OFF",
                    widget: Container(
                      height: 18,
                      width: 20,
                      alignment: Alignment.centerRight,
                      child: Switch(
                        onChanged: (bool value) {
                          MessageDao.messagesRef.ref.child("SENSOR_DATA").update({"fan_status": fanStatus ? "0" : "1"});
                        },
                        value: !fanStatus,
                        activeColor: Colors.white,
                        activeTrackColor: colorPrimary,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     'Warning notification show if fan or light load ON and battery life will goes to 20%',
                  //     style: sfProStyle600SemiBold.copyWith(fontSize: 15, color: colorPrimary),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  int.parse(snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(2).value.toString()) < 50
                      ? Text(
                          'Warning!!!',
                          style: sfProStyle700Bold.copyWith(fontSize: 25, color: Colors.red),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(width: 0),
                  spaceHeight15,
                  CustomButton(
                      btnTxt: 'Astronomy picture',
                      onTap: () {
                        Helper.toScreen( const AstronomyDayScreen());

                      }),
                  spaceHeight15,
                  CustomButton(
                      btnTxt: 'Planets',
                      onTap: () {
                        Helper.toScreen( const PlanetScreen());
                        // Helper.toRemoveUntilScreen(const AstronomyScreen());
                      }),
                ],
              ),
            );
          }),
    );
  }

  Widget eachRow(String key, String value, {Widget? widget}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(border: Border.all(color: colorPrimary.withOpacity(.6)), borderRadius: BorderRadius.circular(4)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(key, style: sfProStyle600SemiBold.copyWith(fontSize: 14, color: Colors.black))),
            VerticalDivider(color: colorIcons.withOpacity(.6), thickness: 1.1),
            Expanded(
                child: widget ??
                    Text(value, textAlign: TextAlign.end, style: sfProStyle400Regular.copyWith(fontSize: 16, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
