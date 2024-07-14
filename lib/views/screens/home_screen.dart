import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restoran_qidirish_dasturi/services/geolocator_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Point? myLocation;
  late YandexMapController mapController;

  void goToMyLocation() {
    mapController.moveCamera(
      animation: const MapAnimation(),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myLocation!,
          zoom: 20,
        ),
      ),
    );
  }

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    goToMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: GeolocatorService.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            myLocation = Point(
              latitude: snapshot.data!.latitude,
              longitude: snapshot.data!.longitude,
            );

            return Stack(
              children: [
                YandexMap(
                  onMapCreated: onMapCreated,
                  mapObjects: [
                    PlacemarkMapObject(
                      mapId: const MapObjectId("myLocation"),
                      point: myLocation!,
                      icon: PlacemarkIcon.single(
                        PlacemarkIconStyle(
                          image: BitmapDescriptor.fromAssetImage(
                              "assets/route_start.png"),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: MediaQuery.of(context).viewPadding.top + 20,
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search here",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.remove),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
