import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minggu_6_gmaps/data_dummy.dart';
import 'package:minggu_6_gmaps/map_type_google.dart';
import 'package:minggu_6_gmaps/data/places_data.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  @override
  State<MapsV1Page> createState() => _MapsV1PageState();
}

class _MapsV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double latitude = -7.2804494;
  double longitude = 112.7947228;
  var mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps v1"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
            itemBuilder: (context) {
              return googleMapTypes.map(
                (typeGoogle) {
                  return PopupMenuItem(
                    value: typeGoogle.type,
                    child: Text(typeGoogle.type.name),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildGoogleMaps(),
          _buildDetailCard()
        ],
      ),
    );
  }

  Widget _buildGoogleMaps() {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 13,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
    );
  }

  void onSelectedMapType(Type value) {
    setState(() {
      switch(value) {
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.Satellite:
          mapType = MapType.satellite;
          break;
        case Type.Terrain:
          mapType = MapType.terrain;
          break;
        default:
      }
    });
  }

  _buildDetailCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: placesData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: _displayPlaceCard(
                placesData[index]["imageUrl"],
                placesData[index]["name"],
                placesData[index]["latitude"],
                placesData[index]["longitude"]
              ),
            );
          },
        ),
      ),
    );
  }

  _displayPlaceCard(String iamgeUrl, String name, double lat, double lgn) {
    return GestureDetector(
      onTap: () {
        _onClickPlaceCard(lat, lgn);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 90,
        margin: const EdgeInsets.only(bottom: 30),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(iamgeUrl),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.1
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                          Row(
                            children: stars(),
                          )
                        ],
                      ),
                      const Text(
                        "Indonesia \u00B7 Kota Surabaya",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Expanded(
                        child: Text(
                          "Closed \u00B7 Open 09.00 Monday",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> stars() {
    List<Widget> list1 = [];

    for(var i = 0; i < 5; i++) {
      list1.add(
        const Icon(
          Icons.star,
          color: Colors.orange,
          size: 15,
        ),
      );
    }

    return list1;
  }

  _onClickPlaceCard(double lat, double lgn) async {
    setState(() {
      latitude = lat;
      longitude = lgn;
    });

    GoogleMapController controller = await _controller.future;
    final cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17,
      bearing: 192,
      tilt: 55
    );

    final cameraUpdate = CameraUpdate.newCameraPosition(
      cameraPosition
    );

    controller.animateCamera(cameraUpdate);
  }
}