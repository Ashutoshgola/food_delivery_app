import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/cart_item.dart';
import '../screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<FoodItem> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  late List<FoodItem> cartItems;
  late Map<String, int> itemQuantities;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
    itemQuantities = {};
    for (var item in cartItems) {
      itemQuantities[item.name] = itemQuantities[item.name] ?? 1;
    }
  }

  void addQuantity(String itemName) {
    setState(() {
      itemQuantities[itemName] = (itemQuantities[itemName] ?? 1) + 1;
    });
  }

  void removeQuantity(String itemName) {
    setState(() {
      if ((itemQuantities[itemName] ?? 1) > 1) {
        itemQuantities[itemName] = (itemQuantities[itemName] ?? 1) - 1;
      }
    });
  }

  void deleteItem(int index) {
    setState(() {
      final itemName = cartItems[index].name;
      cartItems.removeAt(index);
      itemQuantities.remove(itemName);
    });
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * (itemQuantities[item.name] ?? 1);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemWidget(
                        item: item,
                        quantity: itemQuantities[item.name] ?? 1,
                        onAdd: () => addQuantity(item.name),
                        onRemove: () => removeQuantity(item.name),
                        onDelete: () => deleteItem(index),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CheckoutScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}