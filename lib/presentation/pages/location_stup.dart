import 'package:flutter/material.dart';


class LocationSetup extends StatefulWidget {
  const LocationSetup({super.key});

  @override
  State<LocationSetup> createState() => _LocationSetupState();
}

class _LocationSetupState extends State<LocationSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
      ),
    );
  }
}
