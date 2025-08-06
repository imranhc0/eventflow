import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppConstants.borderRadiusMedium,
        ),
        elevation: boxShadow != null ? 0 : 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConstants.borderRadiusMedium,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.borderRadiusMedium,
              ),
              boxShadow: boxShadow,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
