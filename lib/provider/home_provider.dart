import 'dart:async';

import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/model/astrony_day_model.dart';
import 'package:women_safety/model/base/api_response.dart';
import 'package:women_safety/model/planet1_model.dart';
import 'package:women_safety/model/planet2_model.dart';
import 'package:women_safety/model/satellite_details_model.dart';
import 'package:women_safety/model/satellite_model.dart';
import 'package:women_safety/repository/home_repo.dart';
import 'package:women_safety/screen/dashboard/dashboard_screen.dart';
import 'package:women_safety/util/helper.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepo homeRepo;

  HomeProvider({required this.homeRepo}) {
    allSatelliteTypeList = [];
    allSatelliteTypeList = homeRepo.satelliteTypes;
    selectedSatelliteType = allSatelliteTypeList[0];
  }

  List<SatelliteModel> satelliteList = [];
  bool isLoadingSatellite = false;
  Set<Marker> markers = {};
  List<SatelliteType> allSatelliteTypeList = [];
  SatelliteType selectedSatelliteType = SatelliteType(name: 'All', type: 0);

  changeSatelliteType(SatelliteType type) {
    selectedSatelliteType = type;
    initializeAllSatellite();
    initializeAllSatellite();
  }

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  SatelliteModel selectSatelliteModel = SatelliteModel();

  void initializeAllSatellite({bool isFirstTime = false}) async {
    isLoadingSatellite = true;
    satelliteList = [];
    markers = {};
    if (!isFirstTime) notifyListeners();
    ApiResponse apiResponse = await homeRepo.getAllSatellite(type: selectedSatelliteType.type);
    isLoadingSatellite = false;

    if (apiResponse.response.statusCode == 200) {
      apiResponse.response.data['above'].forEach((element) async {
        SatelliteModel v = SatelliteModel.fromJson(element);

        markers.add(Marker(
            markerId: MarkerId(element['satid'].toString()),
            onTap: () {
              selectSatelliteModel = v;
              initializeSatelliteDetails();
              _showBottomSheet(Helper.navigatorKey.currentState!.context);
            },
            position: LatLng(double.parse(element['satlat'].toString()), double.parse(element['satlng'].toString())),
            infoWindow: InfoWindow(title: element['satname']),
            icon: await MarkerIcon.pictureAsset(assetPath: 'assets/images/satellite.png', width: 200, height: 200)));
        satelliteList.add(v);

        notifyListeners();
      });
      // notifyListeners();
    } else {
      // showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
    }
    notifyListeners();

    // // Schedule the next call in 2 minutes
    Timer(const Duration(seconds: 20), () {
      initializeAllSatellite();
    });
  }

  SatelliteDetailsModel satelliteDetailsModel = SatelliteDetailsModel();
  bool isLoadingSatelliteDetails = false;

  void initializeSatelliteDetails() async {
    isLoadingSatelliteDetails = true;
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.satelliteDetails(id: selectSatelliteModel.satid! as int);
    isLoadingSatelliteDetails = false;
    if (apiResponse.response.statusCode == 200) {
      satelliteDetailsModel = SatelliteDetailsModel.fromJson(apiResponse.response.data);
    } else {
      // showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
    }
    notifyListeners();
  }

  // Function to display the bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<HomeProvider>(
            builder: (context, homeProvider, child) => Container(
                  height: 400,
                  padding: const EdgeInsets.all(16.0),
                  child: homeProvider.isLoadingSatelliteDetails
                      ? SizedBox(
                          width: screenWeight(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Satellite Details',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text('Name: ${homeProvider.selectSatelliteModel.satname ?? 'N/A'}'),
                            const SizedBox(height: 8),
                            Text('ID: ${homeProvider.selectSatelliteModel.satid ?? 'N/A'}'),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView.builder(
                                itemCount: homeProvider.satelliteDetailsModel.passes?.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var pass = homeProvider.satelliteDetailsModel.passes![index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Pass ${index + 1}:'),
                                      Text('  Start Azimuth: ${pass.startAz} (${pass.startAzCompass})'),
                                      Text('  Max Azimuth: ${pass.maxAz} (${pass.maxAzCompass})'),
                                      Text('  Max Elevation: ${pass.maxEl}'),
                                      Text('  End Azimuth: ${pass.endAz} (${pass.endAzCompass})'),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DashboardScreen()));
                                  },
                                  child: const Text('Solar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                ));
      },
    );
  }

  AstronyDayModel astronyDayModel = AstronyDayModel();
  bool isLoadingAstronomyDay = false;

  void initializeAstronomyDay() async {
    isLoadingAstronomyDay = true;
    // notifyListeners();
    ApiResponse apiResponse = await homeRepo.astronomyDay();
    isLoadingAstronomyDay = false;
    if (apiResponse.response.statusCode == 200) {
      astronyDayModel = AstronyDayModel.fromJson(apiResponse.response.data);
    } else {
      // showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
    }
    notifyListeners();
  }

  List<Planet> planetList = [
    Planet(name: 'Mercury', image: 'assets/images/mercury.png'),
    Planet(name: 'Venus', image: 'assets/images/venus.png'),
    Planet(name: 'Earth', image: 'assets/images/earth.png'),
    Planet(name: 'Mars', image: 'assets/images/mars.png'),
    Planet(name: 'Jupiter', image: 'assets/images/jupiter.png'),
    Planet(name: 'Saturn', image: 'assets/images/saturn.png'),
    Planet(name: 'Uranus', image: 'assets/images/uranus.png'),
    Planet(name: 'Neptune', image: 'assets/images/neptune.png'),
  ];

  String selectPlanet = 'Mercury';

  changePlanet(int position) {
    selectPlanet = planetList[position].name;
    initializePlanet1();
    initializePlanet1();
  }

  Planet1Model planet1model = Planet1Model();
  Planet2Model planet2model = Planet2Model();
  bool isLoadingPlanet1 = false;

  initializePlanet1() async {
    isLoadingPlanet1 = true;
    notifyListeners();
    initializePlanet2();
    ApiResponse apiResponse = await homeRepo.planets1(selectPlanet);
    isLoadingPlanet1 = false;
    if (apiResponse.response.statusCode == 200) {
      planet1model = Planet1Model.fromJson(apiResponse.response.data[0]);
    } else {
      // showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
    }
    notifyListeners();
  }

  initializePlanet2() async {
    // isLoadingPlanet1 = true;
    ApiResponse apiResponse = await homeRepo.planets2(selectPlanet);
    // isLoadingPlanet1 = false;
    if (apiResponse.response.statusCode == 200) {
      planet2model = Planet2Model.fromJson(apiResponse.response.data);
    } else {
      // showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
    }
    notifyListeners();
  }
}

class SatelliteType {
  final String name;
  final int type;

  SatelliteType({required this.name, required this.type});
}

class Planet {
  final String name;
  final String image;

  Planet({required this.name, required this.image});
}
