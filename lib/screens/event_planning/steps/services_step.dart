import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class ServicesStep extends StatelessWidget {
  final List<String> selectedServices;
  final Function(List<String>) onServicesChanged;
  final VoidCallback onNext;

  const ServicesStep({
    super.key,
    required this.selectedServices,
    required this.onServicesChanged,
    required this.onNext,
  });

  void _toggleService(String service) {
    final updatedServices = List<String>.from(selectedServices);
    if (updatedServices.contains(service)) {
      updatedServices.remove(service);
    } else {
      updatedServices.add(service);
    }
    onServicesChanged(updatedServices);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add additional services',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          // Services List
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...AppConstants.services.map((service) {
                    final isSelected = selectedServices.contains(service);
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: AppConstants.paddingMedium,
                      ),
                      child: CustomCard(
                        backgroundColor: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.white,
                        onTap: () => _toggleService(service),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelected,
                              onChanged: (value) => _toggleService(service),
                              activeColor: AppColors.primary,
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Icon(
                              _getServiceIcon(service),
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.grey,
                              size: 24,
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.black,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getServiceDescription(service),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.darkGrey),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _getServicePrice(service),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: AppConstants.paddingMedium),

                  // Selected Services Summary
                  if (selectedServices.isNotEmpty)
                    CustomCard(
                      backgroundColor: AppColors.lightGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Services',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: AppConstants.paddingSmall),
                          ...selectedServices.map(
                            (service) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    service,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    _getServicePrice(service),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Services Total:',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '৳${_calculateServicesTotal()}',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(
                    height: AppConstants.paddingLarge,
                  ), // Extra space
                ],
              ),
            ),
          ),

          // Continue Button
          CustomButton(
            text: 'Continue to Date & Time',
            onPressed: onNext,
            width: double.infinity,
            height: 50,
          ),
        ],
      ),
    );
  }

  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'photography':
        return Icons.camera_alt;
      case 'videography':
        return Icons.videocam;
      case 'decor':
        return Icons.palette;
      case 'guest handling':
        return Icons.people;
      case 'music/dj':
        return Icons.music_note;
      default:
        return Icons.star;
    }
  }

  String _getServiceDescription(String service) {
    switch (service.toLowerCase()) {
      case 'photography':
        return 'Professional event photography';
      case 'videography':
        return 'High-quality video recording';
      case 'decor':
        return 'Beautiful event decoration';
      case 'guest handling':
        return 'Professional guest management';
      case 'music/dj':
        return 'Music and entertainment';
      default:
        return 'Additional service';
    }
  }

  String _getServicePrice(String service) {
    switch (service.toLowerCase()) {
      case 'photography':
        return '৳8,000';
      case 'videography':
        return '৳12,000';
      case 'decor':
        return '৳15,000';
      case 'guest handling':
        return '৳5,000';
      case 'music/dj':
        return '৳10,000';
      default:
        return '৳5,000';
    }
  }

  int _calculateServicesTotal() {
    int total = 0;
    for (String service in selectedServices) {
      switch (service.toLowerCase()) {
        case 'photography':
          total += 8000;
          break;
        case 'videography':
          total += 12000;
          break;
        case 'decor':
          total += 15000;
          break;
        case 'guest handling':
          total += 5000;
          break;
        case 'music/dj':
          total += 10000;
          break;
        default:
          total += 5000;
      }
    }
    return total;
  }
}
