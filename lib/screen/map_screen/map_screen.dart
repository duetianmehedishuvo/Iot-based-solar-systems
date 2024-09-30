
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/home_provider.dart';
import 'package:women_safety/util/helper.dart';
import 'package:women_safety/util/size.util.dart';
import 'package:women_safety/widgets/custom_loader.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(Helper.navigatorKey.currentState!.context, listen: false).initializeAllSatellite(isFirstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => Scaffold(
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target: LatLng(24.0178, 90.4182), zoom: 10.0),
                    markers: homeProvider.markers,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<SatelliteType>(
                        value: homeProvider.selectedSatelliteType,
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        onChanged: (SatelliteType? newValue) {
                          homeProvider.changeSatelliteType(newValue!);
                        },
                        items: homeProvider.allSatelliteTypeList.map<DropdownMenuItem<SatelliteType>>((SatelliteType satellite) {
                          return DropdownMenuItem<SatelliteType>(
                            value: satellite,
                            child: Text(satellite.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Positioned.directional(
                      textDirection: Directionality.of(context),
                      end: -120,
                      bottom: 5,
                      child: homeProvider.isLoadingSatellite ? CustomLoader() : spaceZero)
                ],
              ),
            ));
  }
}
