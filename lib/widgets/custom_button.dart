import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor ?? AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppConstants.borderRadiusSmall,
                  ),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? AppColors.primary,
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppConstants.borderRadiusSmall,
                  ),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? AppColors.white,
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
