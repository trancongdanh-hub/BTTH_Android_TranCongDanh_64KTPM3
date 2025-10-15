import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail',
      debugShowCheckedModeBanner: false,
      home: const ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Center(
              child: Image.asset(
                "assets/images/bag.jpg",
                height: 180,
              ),
            ),
            const SizedBox(height: 12),

            // Title & Price
            const Text(
              "Aristocratic Hand Bag",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Text(
              "Office Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Price\n\$234",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 16),

            // Color & Size
            Row(
              children: [
                const Text("Color", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Row(
                  children: [
                    buildColorDot(Colors.brown, true),
                    buildColorDot(Colors.grey, false),
                    buildColorDot(Colors.black, false),
                  ],
                ),
                const Spacer(),
                const Text("Size", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                const Text("12 cm",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              "Lorem Ipsum is simply dummy text of the printing and "
                  "typesetting industry. Lorem Ipsum has been the industry's "
                  "standard dummy text ever since.",
              style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 16),

            // Quantity & Favorite
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        quantity.toString().padLeft(2, '0'),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Bottom bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -1),
                blurRadius: 6,
                color: Colors.black.withOpacity(0.1))
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.shopping_cart, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "BUY NOW",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorDot(Color color, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: selected ? Border.all(color: Colors.blue, width: 2) : null,
      ),
    );
  }
}
