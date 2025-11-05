import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authService = AuthService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  void _signup() async {
  setState(() => _loading = true);

  final user = await _authService.signUp(
    _nameController.text.trim(),
    _emailController.text.trim(),
    _passwordController.text.trim(),
  );

  setState(() => _loading = false);

  if (user != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful! Redirecting...')),
    );
    // ✅ DO NOT navigate manually. StreamBuilder in main.dart handles it.
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup failed. Try again.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signup,
                        child: const Text("Sign Up"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
