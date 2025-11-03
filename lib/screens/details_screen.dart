import 'package:flutter/material.dart';
import '../models/food_item.dart';

class DetailsScreen extends StatelessWidget {
  final FoodItem item;
  final Function(FoodItem) onAddToCart;

  const DetailsScreen({super.key, required this.item, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹${item.price}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () {
                    onAddToCart(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.name} added to cart!')),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("Add to Cart"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
