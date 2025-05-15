import 'package:flutter/material.dart';
import 'package:dreamflow/screens/onboarding_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


/// An animated splash screen that transitions to the onboarding screen.
/// 
/// This screen displays after the native splash and provides a visually
/// engaging introduction to the app with multiple animations including
/// fade-in, scale, and opacity effects.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    
    // Start animations
    _controller.forward();
    
    // Navigate to onboarding screen after delay
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
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
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(isDarkMode ? 0.5 : 0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.auto_awesome,
                          size: size.width * 0.2,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Animated text
                    DefaultTextStyle(
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'DreamFlow',
                            textStyle: theme.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground,
                            ),
                            duration: const Duration(milliseconds: 2000),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text(
                        'Uma nova experiência visual aguarda por você',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Loading indicator
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}