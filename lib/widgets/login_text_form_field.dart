import 'package:flutter/material.dart';

/// A custom text form field specifically designed for login screens.
/// Features:
/// - Custom styling for focus, hover and error states
/// - Integrated validation
/// - Optional prefix and suffix icons
/// - Password visibility toggle for password fields
class LoginTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;

  const LoginTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool _obscureText = true;
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: FocusScope(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : _isHovered
                      ? [
                          BoxShadow(
                            color: theme.colorScheme.onSurface.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? _obscureText : false,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onEditingComplete: widget.onEditingComplete,
              validator: widget.validator,
              style: theme.textTheme.bodyLarge,
              cursorColor: theme.colorScheme.primary,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.6),
                      )
                    : null,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: _isHovered
                        ? theme.colorScheme.outline.withOpacity(0.8)
                        : theme.colorScheme.outline,
                    width: _isHovered ? 1.5 : 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: 2.0,
                  ),
                ),
                labelStyle: theme.textTheme.labelMedium?.copyWith(
                  color: _isFocused
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
                errorStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}