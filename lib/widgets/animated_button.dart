import 'package:flutter/material.dart';

/// A beautifully animated button that provides visual feedback on interaction.
/// 
/// This button enhances user experience by providing visual feedback through
/// animations when pressed, hovered, or focused. It supports customization
/// of colors, text, and icons, and adapts to the current app theme.
/// 
/// Features:
/// - Scale animation on press
/// - Color transition animations
/// - Optional leading and trailing icons
/// - Customizable gradient background
/// - Ripple effect on tap
class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;
  final bool isPrimary;

  const AnimatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.isLoading) {
      setState(() {
        _isPressed = true;
      });
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isLoading) {
      setState(() {
        _isPressed = false;
      });
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (!widget.isLoading) {
      setState(() {
        _isPressed = false;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Define colors based on theme and button state
    final Color primaryColor = theme.colorScheme.primary;
    final Color backgroundColor = widget.isPrimary
        ? primaryColor
        : Colors.transparent;
    final Color textColor = widget.isPrimary
        ? theme.colorScheme.onPrimary
        : primaryColor;
    
    // Gradient for the button background
    final gradient = widget.isPrimary
        ? LinearGradient(
            colors: [
              primaryColor,
              Color.lerp(primaryColor, theme.colorScheme.secondary, 0.6) ?? primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isFullWidth ? double.infinity : null,
                height: 56,
                decoration: BoxDecoration(
                  gradient: gradient,
                  color: gradient == null ? backgroundColor : null,
                  borderRadius: BorderRadius.circular(14),
                  border: !widget.isPrimary
                      ? Border.all(color: primaryColor, width: 1.5)
                      : null,
                  boxShadow: _isHovered && !_isPressed
                      ? [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : _isPressed
                          ? [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : widget.isPrimary
                              ? [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.isLoading ? null : widget.onPressed,
                    borderRadius: BorderRadius.circular(14),
                    splashColor: textColor.withOpacity(0.1),
                    highlightColor: textColor.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                        child: widget.isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                                ),
                              )
                            : Row(
                                mainAxisSize: widget.isFullWidth
                                    ? MainAxisSize.max
                                    : MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.leadingIcon != null) ...[   
                                    Icon(
                                      widget.leadingIcon,
                                      color: textColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                  Text(
                                    widget.text,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (widget.trailingIcon != null) ...[   
                                    const SizedBox(width: 12),
                                    Icon(
                                      widget.trailingIcon,
                                      color: textColor,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}