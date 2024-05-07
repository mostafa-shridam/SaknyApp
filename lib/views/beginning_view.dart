import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/views/login_view.dart';
import 'package:sakny/views/signup_view.dart';

class BeginningScreen extends StatelessWidget {
  const BeginningScreen({super.key});

  static String id = 'began';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (route) => false);
              },
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(
                  Size.fromWidth(100),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(defaultColor),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignUpScreen.id, (route) => false);
              },
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(
                  Size.fromWidth(100),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  defaultColor,
                ),
              ),
              child: const Text(
                'SignUp',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
