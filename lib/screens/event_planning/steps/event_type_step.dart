import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class EventTypeStep extends StatelessWidget {
  final String? selectedEventType;
  final Function(String) onEventTypeSelected;
  final VoidCallback onNext;

  const EventTypeStep({
    super.key,
    required this.selectedEventType,
    required this.onEventTypeSelected,
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
            'What type of event are you planning?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Event Types Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppConstants.paddingMedium,
                mainAxisSpacing: AppConstants.paddingMedium,
                childAspectRatio: 1.2,
              ),
              itemCount: AppConstants.eventTypes.length,
              itemBuilder: (context, index) {
                final eventType = AppConstants.eventTypes[index];
                final isSelected = selectedEventType == eventType;
                
                return GestureDetector(
                  onTap: () => onEventTypeSelected(eventType),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getEventIcon(eventType),
                          size: 32,
                          color: isSelected ? AppColors.white : AppColors.primary,
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          eventType,
                          style: TextStyle(
                            color: isSelected ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          // Continue Button
          CustomButton(
            text: 'Continue to Venue Selection',
            onPressed: selectedEventType != null ? onNext : () {},
            width: double.infinity,
            height: 50,
            backgroundColor: selectedEventType != null 
                ? AppColors.primary 
                : AppColors.grey,
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String eventType) {
    switch (eventType.toLowerCase()) {
      case 'wedding':
        return Icons.favorite;
      case 'birthday':
        return Icons.cake;
      case 'anniversary':
        return Icons.celebration;
      case 'graduation':
        return Icons.school;
      case 'corporate':
        return Icons.business;
      case 'baby shower':
        return Icons.child_care;
      case 'engagement':
        return Icons.diamond;
      case 'housewarming':
        return Icons.home;
      default:
        return Icons.event;
    }
  }
}
