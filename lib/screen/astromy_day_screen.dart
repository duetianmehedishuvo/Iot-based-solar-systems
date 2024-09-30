import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/home_provider.dart';
import 'package:women_safety/widgets/custom_cached_network_image.dart';

class AstronomyDayScreen extends StatefulWidget {
  const AstronomyDayScreen({super.key});

  @override
  _AstronomyDayScreenState createState() => _AstronomyDayScreenState();
}

class _AstronomyDayScreenState extends State<AstronomyDayScreen> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Provider.of<HomeProvider>(context, listen: false).initializeAstronomyDay();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Astronomy picture of the day', style: TextStyle(fontSize: 14)), centerTitle: true),
        body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => homeProvider.isLoadingAstronomyDay
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homeProvider.astronyDayModel.title ?? '',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        homeProvider.astronyDayModel.date ?? '',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      // imageData != null
                      //     ? Image.memory(imageData!)
                      //     : SizedBox.shrink(),
                      // Image.network(homeProvider.astronyDayModel.hdurl!,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomCachedNetworkImage(url: homeProvider.astronyDayModel.hdurl ?? '', height: 280)),
                      const SizedBox(height: 10),
                      Text(homeProvider.astronyDayModel.explanation ?? '', textAlign: TextAlign.justify, style: const TextStyle(fontSize: 15)),
                      // SizedBox(height: 10),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     final url = homeProvider.astronyDayModel.url;
                      //     if (await canLaunchUrl(Uri.parse(url!))) {
                      //       await launchUrl(Uri.parse(url));
                      //     } else {
                      //       // Handle error
                      //     }
                      //   },
                      //   child: const Text('Open in Browser'),
                      // ),
                    ],
                  ),
                ),
        ));
  }
}
