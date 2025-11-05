import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';

import '../models/food_item.dart';
import '../services/auth_service.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItem> cart = [];
  String searchQuery = "";
  String currentLocation = "Fetching location...";
  bool isLoadingLocation = true;
  final AuthService _authService = AuthService();


  

  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Legos",
      "image": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800",
      "rating": 4.3,
      "time": "30 mins",
      "foods": [
        FoodItem(
          id: '4',
          name: "Paneer Butter Masala",
          description: "Creamy paneer curry with rich butter sauce.",
          price: 180,
          imageUrl: "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400",
        ),
        FoodItem(
          id: '5',
          name: "Butter Naan",
          description: "Soft and fluffy Indian bread with butter.",
          price: 40,
          imageUrl: "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400",
        ),
        FoodItem(
          id: '6',
          name: "Dal Makhani",
          description: "Slow-cooked black lentils with cream and spices.",
          price: 160,
          imageUrl: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400",
        ),
        FoodItem(
          id: '7',
          name: "Biryani",
          description: "Fragrant basmati rice with spices and meat.",
          price: 220,
          imageUrl: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400",
        ),
      ]
    },
    {
      "name": "Amul Eatery",
      "image": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800",
      "rating": 4.6,
      "time": "25 mins",
      "foods": [
        FoodItem(
          id: '8',
          name: "Cheese Burger",
          description: "Juicy burger with melted cheese and fresh veggies.",
          price: 120,
          imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400",
        ),
        FoodItem(
          id: '9',
          name: "French Fries",
          description: "Crispy golden fries seasoned to perfection.",
          price: 80,
          imageUrl: "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400",
        ),
        FoodItem(
          id: '10',
          name: "Chicken Wings",
          description: "Spicy chicken wings with tangy sauce.",
          price: 180,
          imageUrl: "https://images.unsplash.com/photo-1608039829572-78524f79c4c7?w=400",
        ),
        FoodItem(
          id: '11',
          name: "Onion Rings",
          description: "Crispy battered onion rings.",
          price: 90,
          imageUrl: "https://images.unsplash.com/photo-1639024471283-03518883512d?w=400",
        ),
      ]
    },
    {
      "name": "Coca Cola",
      "image": "https://images.unsplash.com/photo-1589307004173-3c952fece49b?w=800",
      "rating": 4.4,
      "time": "20 mins",
      "foods": [
        FoodItem(
          id: '12',
          name: "White Sauce Pasta",
          description: "Creamy white sauce pasta with vegetables.",
          price: 160,
          imageUrl: "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400",
        ),
        FoodItem(
          id: '13',
          name: "Garlic Bread",
          description: "Toasted bread with garlic butter and herbs.",
          price: 70,
          imageUrl: "https://images.unsplash.com/photo-1573140401552-3fab0b24306f?w=400",
        ),
        FoodItem(
          id: '14',
          name: "Red Sauce Pasta",
          description: "Classic red sauce pasta with tomatoes and herbs.",
          price: 150,
          imageUrl: "https://images.unsplash.com/photo-1598866594230-a7c12756260f?w=400",
        ),
        FoodItem(
          id: '15',
          name: "Alfredo Pasta",
          description: "Rich Alfredo sauce pasta with parmesan.",
          price: 190,
          imageUrl: "https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=400",
        ),
      ]
    },
    {
      "name": "Cafe 47",
      "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800",
      "rating": 4.7,
      "time": "35 mins",
      "foods": [
        FoodItem(
          id: '16',
          name: "Margherita Pizza",
          description: "Classic pizza with tomato sauce, mozzarella, and basil.",
          price: 250,
          imageUrl: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400",
        ),
        FoodItem(
          id: '17',
          name: "Pepperoni Pizza",
          description: "Pizza topped with spicy pepperoni and cheese.",
          price: 320,
          imageUrl: "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400",
        ),
        FoodItem(
          id: '18',
          name: "Veggie Supreme",
          description: "Loaded with fresh vegetables and cheese.",
          price: 280,
          imageUrl: "https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=400",
        ),
        FoodItem(
          id: '19',
          name: "Cheese Burst",
          description: "Extra cheesy pizza with bursting cheese.",
          price: 340,
          imageUrl: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400",
        ),
      ]
    },
    {
      "name": "Sushi Station",
      "image": "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800",
      "rating": 4.5,
      "time": "40 mins",
      "foods": [
        FoodItem(
          id: '20',
          name: "California Roll",
          description: "Crab, avocado, and cucumber sushi roll.",
          price: 280,
          imageUrl: "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400",
        ),
        FoodItem(
          id: '21',
          name: "Salmon Nigiri",
          description: "Fresh salmon over seasoned rice.",
          price: 320,
          imageUrl: "https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?w=400",
        ),
        FoodItem(
          id: '22',
          name: "Tuna Sashimi",
          description: "Thinly sliced raw tuna.",
          price: 380,
          imageUrl: "https://images.unsplash.com/photo-1580822184713-fc5400e7fe10?w=400",
        ),
        FoodItem(
          id: '23',
          name: "Dragon Roll",
          description: "Eel and avocado roll with special sauce.",
          price: 350,
          imageUrl: "https://images.unsplash.com/photo-1564489563601-c53cfc451e93?w=400",
        ),
      ]
    },
    {
      "name": "Uncle's Cafe",
      "image": "https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=800",
      "rating": 4.8,
      "time": "15 mins",
      "foods": [
        FoodItem(
          id: '24',
          name: "Chocolate Brownie",
          description: "Rich chocolate brownie with nuts.",
          price: 120,
          imageUrl: "https://images.unsplash.com/photo-1607920591413-4ec007e70023?w=400",
        ),
        FoodItem(
          id: '25',
          name: "Ice Cream Sundae",
          description: "Vanilla ice cream with chocolate syrup and toppings.",
          price: 150,
          imageUrl: "https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400",
        ),
        FoodItem(
          id: '26',
          name: "Cheesecake",
          description: "Creamy cheesecake with berry topping.",
          price: 180,
          imageUrl: "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400",
        ),
        FoodItem(
          id: '27',
          name: "Tiramisu",
          description: "Classic Italian dessert with coffee and mascarpone.",
          price: 200,
          imageUrl: "https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400",
        ),
      ]
    },
  ];

  final List<String> categories = [
    "Pizza",
    "Burger",
    "Dessert",
    "Drinks",
    "Pasta",
    "Snacks",
    "Sushi",
    "Indian"
  ];

  final List<String> bannerImages = [
    "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800",
    "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
    "https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?w=800",
  ];

  void addToCart(FoodItem item) {
    setState(() {
      cart.add(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.name} added to cart!"),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAccountMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Account Options",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: () async {
                  await _authService.logout();
                  Navigator.of(context).pop(); // Close the bottom sheet
                  // Navigate to login screen - the StreamBuilder in main.dart will handle this
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showMenuDialog(Map<String, dynamic> restaurant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant["name"],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 18),
                              Text(
                                " ${restaurant["rating"]} • ${restaurant["time"]}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: restaurant["foods"].length,
                    itemBuilder: (context, index) {
                      final food = restaurant["foods"][index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  food.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.fastfood),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${food.price}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  addToCart(food);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> getFilteredRestaurants() {
    if (searchQuery.isEmpty) {
      return restaurants;
    }

    return restaurants.where((restaurant) {
      final restaurantName = restaurant["name"].toString().toLowerCase();
      final matchesRestaurant = restaurantName.contains(searchQuery.toLowerCase());

      final matchesFood = (restaurant["foods"] as List).any((food) {
        return food.name.toLowerCase().contains(searchQuery.toLowerCase());
      });

      return matchesRestaurant || matchesFood;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = getFilteredRestaurants();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.restaurant_menu, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "UniBite",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
            onPressed: _showAccountMenu,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: -5),
              badgeContent: Text(
                cart.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              showBadge: cart.isNotEmpty,
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.black,
                padding: EdgeInsets.all(5),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cart),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for restaurants or dishes...",
                  prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchQuery = "";
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Show search results or regular content
            if (searchQuery.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Search results for \"$searchQuery\"",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (filteredRestaurants.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(Icons.search_off,
                            size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          "No results found",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ] else ...[
              // 🏙️ Location Bar with Live Location
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    // Refresh location on tap
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on, 
                        color: isLoadingLocation ? Colors.grey : Colors.deepOrange
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Delivering to $currentLocation",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isLoadingLocation)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // 🎠 Carousel Banners
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: bannerImages.map((imgUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image, size: 50),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // 🍕 Category Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepOrange),
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🍴 Restaurant List Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const Text(
                  "Popular Restaurants",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),
            ],

            // 🍴 Restaurant List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            restaurant["image"],
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 180,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.restaurant, size: 50),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "${restaurant["time"]} ⏱️",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant["name"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.white, size: 16),
                                  Text(
                                    " ${restaurant["rating"]}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${restaurant["foods"].length} items available",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showMenuDialog(restaurant);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              "View Menu",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // 🛒 Floating Cart Button
      floatingActionButton: cart.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartItems: cart),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text("Cart (${cart.length})"),
              backgroundColor: Colors.deepOrange,
            )
          : null,
    );
  }
}