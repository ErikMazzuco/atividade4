import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String email;

  const WelcomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bem-vindo, $email!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Volta pra tela de login
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
