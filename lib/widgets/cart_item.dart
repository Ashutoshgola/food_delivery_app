import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartItemWidget extends StatelessWidget {
  final FoodItem item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Icon(Icons.fastfood, size: 30),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${item.price}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Quantity Controls
                  Row(
                    children: [
                      // Decrease Button
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: InkWell(
                          onTap: onRemove,
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                      // Quantity Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Increase Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: InkWell(
                          onTap: onAdd,
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Total Price and Delete
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${item.price * quantity}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}