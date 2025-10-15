import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const SelectLocationScreen({super.key, this.initialLat, this.initialLng});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.initialLat != null && widget.initialLng != null) {
      _pickedLocation = LatLng(widget.initialLat!, widget.initialLng!);
    }
  }

  void _selectLocation(LatLng pos) {
    setState(() {
      _pickedLocation = pos;
    });
  }

  void _confirm() {
    if (_pickedLocation != null) {
      Navigator.pop(context, {
        'lat': _pickedLocation!.latitude,
        'lng': _pickedLocation!.longitude,
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location on Map")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation ?? const LatLng(21.028511, 105.804817), // Hà Nội
          zoom: 14,
        ),
        onTap: _selectLocation,
        markers: _pickedLocation == null
            ? {}
            : {Marker(markerId: const MarkerId("m1"), position: _pickedLocation!)},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirm,
        child: const Icon(Icons.check),
      ),
    );
  }
}
