import 'package:flutter/material.dart';

class Room {
  final String name;
  final String location;
  final String building;
  final String address;
  final String nearbyBusStops;
  final int capacity;
  bool isFavourite;

  Room({
    @required this.name,
    @required this.location,
    @required this.building,
    @required this.address,
    @required this.nearbyBusStops,
    @required this.capacity,
    this.isFavourite = false,
  });
}
