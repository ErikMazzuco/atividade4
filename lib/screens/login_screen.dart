import 'package:flutter/material.dart';
import 'package:dreamflow/screens/home_screen.dart';
import 'package:dreamflow/widgets/login_text_form_field.dart';
import 'package:dreamflow/widgets/animated_button.dart';

/// A login screen with email and password validation.
/// 
/// This screen includes two form fields for email and password input,
/// with validation, and three buttons for login, registration, and
/// password recovery. It uses custom widgets for enhanced visual appeal.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    
    // Start animations after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    // Basic email validation using regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Insira um e-mail válido';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  // Login action (simulated)
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 1500));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate to home screen on successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  // Show a temporary message to the user
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: child,
              ),
            );
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App logo/icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Welcome text
                    Text(
                      'Bem-vindo de volta!',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Faça login para continuar',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Email field
                    LoginTextFormField(
                      controller: _emailController,
                      labelText: 'E-mail',
                      hintText: 'seu.email@exemplo.com',
                      prefixIcon: Icons.email_outlined,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Password field
                    LoginTextFormField(
                      controller: _passwordController,
                      labelText: 'Senha',
                      hintText: 'Sua senha',
                      prefixIcon: Icons.lock_outlined,
                      isPassword: true,
                      validator: _validatePassword,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocusNode,
                      onEditingComplete: _login,
                    ),
                    const SizedBox(height: 16),
                    // Forgot password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showMessage('Recurso de recuperação de senha em implementação'),
                        child: Text(
                          'Esqueci minha senha',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login button
                    AnimatedButton(
                      text: 'Entrar',
                      onPressed: _login,
                      isLoading: _isLoading,
                      isFullWidth: true,
                      leadingIcon: Icons.login_rounded,
                    ),
                    const SizedBox(height: 16),
                    // Register button
                    AnimatedButton(
                      text: 'Registrar-se',
                      onPressed: () => _showMessage('Recurso de registro em implementação'),
                      isFullWidth: true,
                      isPrimary: false,
                      leadingIcon: Icons.person_add_outlined,
                    ),
                    const SizedBox(height: 32),
                    // Optional divider with text
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.outline.withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'ou continue com',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onBackground.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: theme.colorScheme.outline.withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Social login options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google
                        _buildSocialButton(
                          Icons.g_mobiledata_rounded,
                          'Google',
                          const Color(0xFFEA4335),
                        ),
                        const SizedBox(width: 20),
                        // Facebook
                        _buildSocialButton(
                          Icons.facebook_rounded,
                          'Facebook',
                          const Color(0xFF1877F2),
                        ),
                        const SizedBox(width: 20),
                        // Apple
                        _buildSocialButton(
                          Icons.apple_rounded,
                          'Apple',
                          isDarkMode ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build social login buttons
  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () => _showMessage('Login com $label em implementação'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 36,
          ),
        ),
      ),
    );
  }
}