import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addVehicle() {
    String name = nameController.text.trim();
    double mileage = double.tryParse(mileageController.text) ?? 0;
    int year = int.tryParse(yearController.text) ?? 0;

    if (name.isNotEmpty && mileage > 0 && year > 1900) {
      FirebaseFirestore.instance.collection('vehicles').add({
        'name': name,
        'mileage': mileage,
        'manufactureYear': year,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue, title: const Text("Add Vehicle")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: "Vehicle Name",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: mileageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Mileage (km/l)",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Manufacture Year",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addVehicle();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All fields are required"),
                      ),
                    );
                  }
                },
                child: const Text("Add Vehicle",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
