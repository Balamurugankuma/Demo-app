import 'package:flutter/material.dart';
import 'package:untitled5/presentation/homepage.dart';
import 'package:untitled5/presentation/register.dart';
import 'package:untitled5/presentation/repository.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    try {
      setState(() => _isLoading = true);

      await authRepository.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      _emailController.clear();
      _passwordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOG IN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              const SizedBox(height: 25),

              _buildTextField(
                _emailController,
                "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 12),

              _buildTextField(
                _passwordController,
                "Password",
                isPassword: true,
              ),

              const SizedBox(height: 25),

              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 100,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    onTap: goToRegister,
                    child: const Text(
                      'Register now',
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

  Widget _buildTextField(
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
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: controller,
          obscureText: isPassword ? !_isPasswordVisible : false,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
