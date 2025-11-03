import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(item.imageUrl, width: 60, fit: BoxFit.cover),
        title: Text(item.name),
        subtitle: Text("₹${item.price}"),
        onTap: onTap,
      ),
    );
  }
}
