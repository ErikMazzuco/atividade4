import 'package:flutter/material.dart';
import 'package:dreamflow/screens/login_screen.dart';
import 'package:dreamflow/widgets/onboarding_page.dart';
import 'package:dreamflow/widgets/animated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


/// A multi-page onboarding screen using PageView.
/// 
/// This screen displays a series of onboarding pages that introduce
/// users to the app's key features. It includes smooth page transitions,
/// page indicators, and navigation controls.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // Onboarding pages content
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Bem-vindo ao DreamFlow',
      'description': 'Um aplicativo moderno com interface intuitiva para facilitar sua experiência.',
      'imageUrl': "https://pixabay.com/get/gc3363d92f277b533622a22b33eca1cc68568a898239c3bb5d7ce8cb329942f6975ad86909b6b55b8889f4485d775d82bdfb3bd62ce607b2be88937a15e14242d_1280.png",
      'accentColor': const Color(0xFF6F61EF),
    },
    {
      'title': 'Personalização Completa',
      'description': 'Adapte o aplicativo ao seu estilo com nossos temas claro e escuro.',
      'imageUrl': "https://pixabay.com/get/g4b529907e5969040be6e0b1afd243eded498b9a7bf2b585d980cc53b6468b6c42082adf1e06570c9d11063d4761aa1b9794d0cc896e8109656bdd0bae0aeef4b_1280.png",
      'accentColor': const Color(0xFF39D2C0),
    },
    {
      'title': 'Tudo Pronto!',
      'description': 'Você está pronto para começar sua jornada com o DreamFlow.',
      'imageUrl': "https://pixabay.com/get/g5e8624c66bf5fd4955feb3c94cf90b9fc1dcb8c2858c439e10d6ecd7494e1b24ef65c24d80fd315960edb059b4450649f2889d6a8711e8bbe2c998bd87be1f4c_1280.png",
      'accentColor': const Color(0xFFEE8B60),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.easeInOut;
          var curveTween = CurveTween(curve: curve);
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            animation.drive(curveTween),
          );
          return FadeTransition(opacity: fadeAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at the top
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _currentPage < _pages.length - 1
                  ? TextButton(
                      onPressed: _skipToEnd,
                      child: Text(
                        'Pular',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox(),
              ),
            ),
            // Page view for onboarding content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPage(
                    title: page['title'],
                    description: page['description'],
                    imageUrl: page['imageUrl'],
                    accentColor: page['accentColor'],
                  );
                },
              ),
            ),
            // Page indicator and navigation buttons
            Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.colorScheme.primary.withOpacity(0.3),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Next/Start button
                  AnimatedButton(
                    text: _currentPage == _pages.length - 1 ? 'Começar' : 'Continuar',
                    onPressed: _nextPage,
                    isFullWidth: true,
                    leadingIcon: _currentPage == _pages.length - 1 
                      ? Icons.rocket_launch 
                      : Icons.arrow_forward_rounded,
                  ),
                  const SizedBox(height: 16),
                  // Login directly button on last page
                  if (_currentPage == _pages.length - 1)
                    AnimatedButton(
                      text: 'Já tenho uma conta',
                      onPressed: _navigateToLogin,
                      isFullWidth: true,
                      isPrimary: false,
                      leadingIcon: Icons.login_rounded,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}