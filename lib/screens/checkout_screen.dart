import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', phone = '', address = '', city = '', pincode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
                onSaved: (val) => name = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.length != 10 ? "Enter valid phone" : null,
                onSaved: (val) => phone = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Street Address"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
                onSaved: (val) => address = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "City"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
                onSaved: (val) => city = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "PIN Code"),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.length != 6 ? "Enter valid PIN" : null,
                onSaved: (val) => pincode = val ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Confirm Address & Place Order"),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // process address, continue with payment or order confirmation
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderConfirmationScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
