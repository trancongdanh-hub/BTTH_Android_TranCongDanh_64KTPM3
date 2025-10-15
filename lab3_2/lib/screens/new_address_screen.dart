import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/address_provider.dart';
import '../models/address.dart';
import 'select_location_screen.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone, _province, _district, _ward, _details;
  double? _lat, _lng;

  final List<String> _provinces = ["Hà Nội", "Hồ Chí Minh", "Đà Nẵng"];
  final List<String> _districts = ["Quận 1", "Quận 2", "Quận 3"];
  final List<String> _wards = ["Phường A", "Phường B", "Phường C"];

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newAddr = Address(
        recipientName: _name!,
        phoneNumber: _phone!,
        province: _province!,
        district: _district!,
        ward: _ward!,
        details: _details!,
        latitude: _lat,
        longitude: _lng,
      );

      context.read<AddressProvider>().addAddress(newAddr);
      Navigator.pop(context);
    }
  }

  void _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectLocationScreen(
          initialLat: _lat,
          initialLng: _lng,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _lat = result['lat'];
        _lng = result['lng'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Address")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Recipient Name"),
                validator: (val) => val!.isEmpty ? "Required" : null,
                onSaved: (val) => _name = val,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (val) => val!.isEmpty ? "Required" : null,
                onSaved: (val) => _phone = val,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Province/City"),
                items: _provinces.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => _province = val,
                validator: (val) => val == null ? "Required" : null,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "District"),
                items: _districts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) => _district = val,
                validator: (val) => val == null ? "Required" : null,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Ward"),
                items: _wards.map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
                onChanged: (val) => _ward = val,
                validator: (val) => val == null ? "Required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Address Details"),
                validator: (val) => val!.isEmpty ? "Required" : null,
                onSaved: (val) => _details = val,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickLocation,
                    icon: const Icon(Icons.map),
                    label: const Text("Select on Map"),
                  ),
                  const SizedBox(width: 8),
                  Text(_lat == null ? "No location selected" : "Lat: $_lat, Lng: $_lng"),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text("Save Address"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
