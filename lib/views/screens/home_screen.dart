import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restoran_qidirish_dasturi/controllers/auth_controller.dart';
import 'package:restoran_qidirish_dasturi/services/geolocator_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Point? myLocation = const Point(latitude: 40.7128, longitude: -74.0060);
  late YandexMapController mapController;

  @override
  void initState() {
    super.initState();
    GeolocatorService.getLocation().then(
      (value) {
        myLocation =
            Point(latitude: value.latitude, longitude: value.longitude);
        mapController.moveCamera(
          animation: const MapAnimation(),
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: myLocation!,
            ),
          ),
        );
      },
    );
  }

  void goToMyLocation() {
    mapController.moveCamera(
      animation: const MapAnimation(),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myLocation!,
        ),
      ),
    );
  }

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId("myLocation"),
                point: myLocation!,
                icon: PlacemarkIcon.single()
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
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: FloatingActionButton(
                onPressed: () {
                  goToMyLocation();
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.location_searching),
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
      ),
    );
  }
}
