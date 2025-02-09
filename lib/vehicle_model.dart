import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String name;
  final double mileage;
  final int year;

  Vehicle(
      {required this.id,
      required this.name,
      required this.mileage,
      required this.year});

  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      id: doc.id,
      name: data['name'],
      mileage: data['mileage'].toDouble(),
      year: data['manufactureYear'],
    );
  }

  Color getColor() {
    int currentYear = DateTime.now().year;
    int age = currentYear - year;
    if (mileage >= 15) {
      return (age <= 5) ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }
}
