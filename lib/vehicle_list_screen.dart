import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_vehicle_screen.dart';
import 'package:flutter_application_1/vehicle_model.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Vehicle List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No vehicles found"));
          }

          var vehicles = snapshot.data!.docs
              .map((doc) => Vehicle.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              Vehicle vehicle = vehicles[index];
              return Card(
                color: vehicle.getColor(),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(vehicle.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text(
                    "Mileage: ${vehicle.mileage} km/l, Year: ${vehicle.year}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
