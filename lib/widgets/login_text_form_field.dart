import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;

  const LoginTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        // Aqui você pode colocar uma ação quando o campo é focado (opcional)
      },
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label não pode ser vazio';
          }
          if (!isPassword && !value.contains('@')) {
            return 'E-mail inválido';
          }
          return null;
        },
      ),
    );
  }
}
