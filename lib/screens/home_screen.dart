import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dreamflow/theme/theme_controller.dart';
import 'package:dreamflow/widgets/theme_info_card.dart';
import 'package:dreamflow/widgets/animated_button.dart';

/// A simple home screen that displays a welcome message to the user.
/// 
/// This screen includes a theme toggle button in the app bar, a welcome
/// message, and a theme info card that adapts to the current theme.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('DreamFlow'),
        elevation: 0,
        actions: [
          // Theme toggle button
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeController.themeMode,
            builder: (context, themeMode, _) {
              return IconButton(
                icon: Icon(
                  themeController.getThemeIcon(),
                  color: theme.colorScheme.onBackground,
                ),
                onPressed: () {
                  themeController.toggleTheme();
                  // Show a feedback message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tema alterado para ${themeController.getThemeString()}',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                tooltip: 'Alternar tema',
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, Bem-vindo!',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Você completou o fluxo de login com sucesso!',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Theme info card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ThemeInfoCard(
                    title: 'Personalização de Tema',
                    description: 'Este cartão é um exemplo de componente que se adapta automaticamente ao tema atual do aplicativo. Experimente alternar entre os temas claro, escuro e do sistema para ver as mudanças!',
                    icon: Icons.color_lens_outlined,
                    themeController: themeController,
                    onTap: () {
                      themeController.toggleTheme();
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Features section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Recursos Implementados',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Feature items
                _buildFeatureItem(
                  context,
                  'Splash Screen',
                  'Splash nativa e animada com transições suaves',
                  Icons.play_circle_outline,
                ),
                _buildFeatureItem(
                  context,
                  'Onboarding',
                  'Tour de introdução com páginas deslizantes',
                  Icons.slideshow_outlined,
                ),
                _buildFeatureItem(
                  context,
                  'Login com Validação',
                  'Formulário com validação de campos e feedback visual',
                  Icons.login_outlined,
                ),
                _buildFeatureItem(
                  context,
                  'Temas Dinâmicos',
                  'Alterne entre temas claro e escuro com persistência',
                  Icons.brightness_4_outlined,
                ),
                _buildFeatureItem(
                  context,
                  'Componentes Personalizados',
                  'Widgets customizados para melhor experiência visual',
                  Icons.widgets_outlined,
                ),
                const SizedBox(height: 40),
                // Call to action button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AnimatedButton(
                    text: 'Explorar Mais',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Mais funcionalidades em breve!',
                            style: TextStyle(color: theme.colorScheme.onPrimary),
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    isFullWidth: true,
                    leadingIcon: Icons.explore_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper method to build feature items
  Widget _buildFeatureItem(BuildContext context, String title, String description, IconData icon) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        trailing: Icon(
          Icons.check_circle_outline,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}