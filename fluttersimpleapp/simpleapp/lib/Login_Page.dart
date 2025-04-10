import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'auth_service.dart';
import 'SignUp_Page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFE57200),
      title: Text(
        'Login',
        style: TextStyle(
          fontFamily: 'Teko',
          fontSize: 18.0 * 1.5, // Increased font size by 1.5 times
          color: Color(0xFFF9DCBF), // Set text color to HEX #C8CBD2 (UVA Blue 25%)
        ),
      ),
    ),
    backgroundColor: Color(0xFF232D4B), // Set background color to HEX #232D4B (UVA Blue)
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0 * 1.5), // Increased padding by 1.5 times
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontFamily: 'Teko',
                  fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                  color: Color(0xFFC8CBD2), // Set label text color to HEX #C8CBD2 (UVA Blue 25%)
                ),
              ),
              controller: _emailController,
            ),
            SizedBox(height: 16.0 * 1.5), // Increased sized box height by 1.5 times
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontFamily: 'Teko',
                  fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                  color: Color(0xFFC8CBD2), // Set label text color to HEX #C8CBD2 (UVA Blue 25%)
                ),
              ),
              controller: _passwordController,
            ),
            SizedBox(height: 16.0 * 1.5), // Increased sized box height by 1.5 times
            ElevatedButton(
              onPressed: () async {
                try {
                  await _authService.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } catch (e) {
                  // Handle login errors here (e.g., show an error message)
                  print("Error signing in: $e");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("failed to sign in"),
                  ));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFE57200)), // Set button background color to HEX #E57200 (UVA Orange)
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Teko',
                  fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                  color: Color(0xFFF9DCBF), // Set button text color to HEX #F9DCBF (UVA Orange 25%)
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
