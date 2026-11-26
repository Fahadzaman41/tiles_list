import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Reusable Elevated/Primary Action Button with loading spinner support.
class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.height = 54.0,
    this.borderRadius = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.6),
          elevation: 2,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
