import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/address_provider.dart';
import 'new_address_screen.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = context.watch<AddressProvider>().addresses;

    return Scaffold(
      appBar: AppBar(title: const Text("My Addresses")),
      body: addresses.isEmpty
          ? const Center(child: Text("No addresses added yet"))
          : ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (ctx, i) {
          final addr = addresses[i];
          return ListTile(
            title: Text(addr.recipientName),
            subtitle: Text("${addr.details}, ${addr.ward}, ${addr.district}, ${addr.province}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<AddressProvider>().removeAddress(i);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewAddressScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
