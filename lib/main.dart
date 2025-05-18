import 'package:flutter/material.dart';
import 'package:atividade4/widgets/login_text_form_field.dart';
import 'package:atividade4/database/database_helper.dart';
import 'package:atividade4/pages/welcome_page.dart'; 

void main() {
  runApp(const MyApp());
}

// Raiz do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// Tela de Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _dbReady = false;  // flag pra indicar se banco está pronto

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    await DatabaseHelper.db;  // força a abertura do banco
    setState(() {
      _dbReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_dbReady) {
      // Mostra um loading enquanto o banco abre
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginTextFormField(
                  controller: _emailController,
                  label: 'E-mail',
                  isPassword: false,
                ),
                const SizedBox(height: 20),
                LoginTextFormField(
                  controller: _senhaController,
                  label: 'Senha',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool sucesso = await DatabaseHelper.login(
                        _emailController.text.trim(),
                        _senhaController.text.trim(),
                      );

                      if (!context.mounted) return;

                      if (sucesso) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomePage(
                              email: _emailController.text.trim(),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('E-mail ou senha incorretos')),
                        );
                      }
                    }
                  },
                  child: const Text('Entrar'),
                ),

                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseHelper.insertUser(
                        _emailController.text.trim(),
                        _senhaController.text.trim(),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário registrado com sucesso!')),
                      );
                    }
                  },
                  child: const Text('Registrar-se'),
                ),
                TextButton(
                  onPressed: () {
                    // Esqueci minha senha
                  },
                  child: const Text('Esqueci minha senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}