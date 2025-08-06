import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class FoodPackageStep extends StatelessWidget {
  final String? selectedFoodPackage;
  final Function(String) onFoodPackageSelected;
  final VoidCallback onNext;

  const FoodPackageStep({
    super.key,
    required this.selectedFoodPackage,
    required this.onFoodPackageSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select your food package',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Food Packages
          Expanded(
            child: Column(
              children: [
                ...AppConstants.foodPackages.map((package) {
                  final isSelected = selectedFoodPackage == package;
                  return Container(
                    margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
                    child: CustomCard(
                      backgroundColor: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
                      onTap: () => onFoodPackageSelected(package),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: package,
                            groupValue: selectedFoodPackage,
                            onChanged: (value) {
                              if (value != null) {
                                onFoodPackageSelected(value);
                              }
                            },
                            activeColor: AppColors.primary,
                          ),
                          const SizedBox(width: AppConstants.paddingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? AppColors.primary : AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getPackageDescription(package),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getPackagePrice(package),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                
                const SizedBox(height: AppConstants.paddingMedium),
                
                // Cost Summary Card
                if (selectedFoodPackage != null)
                  CustomCard(
                    backgroundColor: AppColors.lightGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cost Summary',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Food Package:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              _getPackagePrice(selectedFoodPackage!),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal:',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getPackagePrice(selectedFoodPackage!),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Continue Button
          CustomButton(
            text: 'Continue to Services',
            onPressed: selectedFoodPackage != null ? onNext : () {},
            width: double.infinity,
            height: 50,
            backgroundColor: selectedFoodPackage != null 
                ? AppColors.primary 
                : AppColors.grey,
          ),
        ],
      ),
    );
  }

  String _getPackageDescription(String package) {
    switch (package) {
      case 'Basic Package':
        return 'Essential catering with quality ingredients';
      case 'Premium Package':
        return 'Enhanced menu with premium options';
      case 'Luxury Package':
        return 'Gourmet dining experience with premium service';
      default:
        return 'Great food for your event';
    }
  }

  String _getPackagePrice(String package) {
    switch (package) {
      case 'Basic Package':
        return '₹15,000';
      case 'Premium Package':
        return '₹25,000';
      case 'Luxury Package':
        return '₹40,000';
      default:
        return '₹20,000';
    }
  }
}
