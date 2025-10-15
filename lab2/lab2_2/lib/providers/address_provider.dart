import 'package:flutter/foundation.dart';
import '../models/address.dart';

class AddressProvider with ChangeNotifier {
  final List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void updateAddress(int index, Address address) {
    _addresses[index] = address;
    notifyListeners();
  }
}
