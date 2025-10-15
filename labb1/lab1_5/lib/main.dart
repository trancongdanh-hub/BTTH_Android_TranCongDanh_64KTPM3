import 'package:flutter/material.dart';
import 'models/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exercise05-lab09",
      home: Exercise05(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Exercise05 extends StatelessWidget {
  // Tạo danh sách contact mẫu
  final List<Contact> contacts = List.generate(
    20,
        (index) => Contact(
      index,
      'MyContact $index',
      'assets/images/contact.png', // ảnh trong assets
      '088899988$index',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('CONTACTS')),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              const Center(child: Text('Contact yêu thích')),
              const Center(child: Text('Contact gọi gần đây')),
              // Tab danh bạ
              ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(contacts[index].image),
                      ),
                      title: Text(contacts[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(contacts[index].phone),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Material(
          color: Colors.red,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.favorite), text: 'Favourites'),
              Tab(icon: Icon(Icons.recent_actors), text: 'Recent'),
              Tab(icon: Icon(Icons.contacts), text: 'Contacts'),
            ],
          ),
        ),
      ),
    );
  }
}
