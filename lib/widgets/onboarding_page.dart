import 'package:flutter/material.dart';

/// A reusable widget for displaying a single onboarding page.
/// 
/// This widget creates a visually engaging onboarding page with an image,
/// title, and description. It's designed to be used with PageView for
/// creating multi-page onboarding experiences.
/// 
/// Features:
/// - Animated image display
/// - Themeable text styling
/// - Responsive layout for different screen sizes
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color? accentColor;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final color = accentColor ?? theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Image with animation effect
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            curve: Curves.easeOutBack,
            duration: const Duration(milliseconds: 700),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              width: size.width * 0.7,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(isDarkMode ? 0.4 : 0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        color: accentColor ?? Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: (accentColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: accentColor ?? Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const Spacer(),
          // Title with animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? theme.colorScheme.onSurface : theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Description with animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}