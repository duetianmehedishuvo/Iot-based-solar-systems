import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/util/helper.dart';
import 'package:women_safety/util/size.util.dart';
import '../provider/home_provider.dart';
import 'package:women_safety/model/planet1_model.dart';
import 'package:women_safety/model/planet2_model.dart';

class PlanetScreen extends StatefulWidget {
  const PlanetScreen({super.key});

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).initializePlanet1();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planet Details'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            itemCount: homeProvider.planetList.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int position) {
              Provider.of<HomeProvider>(context, listen: false).changePlanet(position);
            },
            itemBuilder: (context, index) {
              if (homeProvider.isLoadingPlanet1||homeProvider.planet2model.picture == null||homeProvider.planet1model.name! == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final planet1 = homeProvider.planet1model;
              final planet2 = homeProvider.planet2model;

              return SizedBox(
                width: screenWeight(),
                height: screenHeight(),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(planet1.name!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Mass: ${planet1.mass}'),
                          Text('Radius: ${planet1.radius}'),
                          Text('Period: ${planet1.period}'),
                          Text('Semi-Major Axis: ${planet1.semiMajorAxis}'),
                          Text('Temperature: ${planet1.temperature}'),
                          Text('Distance Light Year: ${planet1.distanceLightYear}'),
                          Text('Host Star Mass: ${planet1.hostStarMass}'),
                          Text('Host Star Temperature: ${planet1.hostStarTemperature}'),
                          Text('Tagline: ${planet2.tagline}'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    planet2.picture == null ? spaceZero : Image.network(planet2.picture!),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(planet2.description!),
                          const SizedBox(height: 8),
                          Text('Distance From Sun: ${planet2.distanceFromSun}'),
                          Text('Year Length: ${planet2.yearLength}'),
                          Text('Number of Moons: ${planet2.numberOfMoons}'),
                          Text('Namesake: ${planet2.namesake}'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Image.network(
                      planet2.spaceTextureUrl!,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  ListView buildListView(Planet1Model planet1, Planet2Model planet2) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(planet1.name!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Mass: ${planet1.mass}'),
              Text('Radius: ${planet1.radius}'),
              Text('Period: ${planet1.period}'),
              Text('Semi-Major Axis: ${planet1.semiMajorAxis}'),
              Text('Temperature: ${planet1.temperature}'),
              Text('Distance Light Year: ${planet1.distanceLightYear}'),
              Text('Host Star Mass: ${planet1.hostStarMass}'),
              Text('Host Star Temperature: ${planet1.hostStarTemperature}'),
              Text('Tagline: ${planet2.tagline}'),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Image.network(planet2.picture!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(planet2.description!),
              const SizedBox(height: 8),
              Text('Distance From Sun: ${planet2.distanceFromSun}'),
              Text('Year Length: ${planet2.yearLength}'),
              Text('Number of Moons: ${planet2.numberOfMoons}'),
              Text('Namesake: ${planet2.namesake}'),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Image.network(
          planet2.spaceTextureUrl!,
          height: 300,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
