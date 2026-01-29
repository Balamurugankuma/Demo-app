import 'package:flutter/material.dart';
import 'package:untitled5/presentation/homepage.dart';
import 'package:untitled5/presentation/repository.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _RegisterState();
}

class _RegisterState extends State<register> {
  bool isLoading = false;
  bool isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> registerUser() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    try {
      setState(() => isLoading = true);

      await authRepository.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sign Up successful")));

      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void goToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create a new Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              const SizedBox(height: 25),

              _buildField(_nameController, "Name"),
              const SizedBox(height: 12),

              _buildField(
                _emailController,
                "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              _buildField(_passwordController, "Password", isPassword: true),

              const SizedBox(height: 25),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("I am a member? "),
                  GestureDetector(
                    onTap: goToLogin,
                    child: const Text(
                      "Login now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword ? !isPasswordVisible : false,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
