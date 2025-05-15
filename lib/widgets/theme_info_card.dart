import 'package:flutter/material.dart';
import 'package:dreamflow/theme/theme_controller.dart';

/// A custom informative card that changes its appearance based on the current theme.
/// 
/// This widget serves as both a demonstration of theme-responsiveness and
/// a useful UI component to display information to the user. It adapts its
/// colors, icons, and styling based on whether the app is in light or dark mode.
/// 
/// Features:
/// - Smooth animations when theme changes
/// - Custom styling for light and dark modes
/// - Themeable content
/// - Optional actions via onTap callback
class ThemeInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;
  final ThemeController themeController;

  const ThemeInfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.themeController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Different gradient based on theme
    final gradient = isDarkMode
        ? LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.7),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: isDarkMode ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDarkMode
                ? theme.colorScheme.primary.withOpacity(0.3)
                : theme.colorScheme.outline.withOpacity(0.1),
            width: isDarkMode ? 1.5 : 0.5,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: gradient,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? theme.colorScheme.primary.withOpacity(0.2)
                            : theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    ValueListenableBuilder<ThemeMode>(
                      valueListenable: themeController.themeMode,
                      builder: (context, themeMode, _) {
                        return Icon(
                          themeController.getThemeIcon(),
                          color: theme.colorScheme.primary,
                          size: 22,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeController.themeMode,
                  builder: (context, themeMode, _) {
                    return Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tema atual: ${themeController.getThemeString()}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}