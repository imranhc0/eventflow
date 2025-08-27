import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class ReviewConfirmStep extends StatelessWidget {
  final String eventType;
  final String venue;
  final String foodPackage;
  final List<String> services;
  final DateTime? date;
  final String time;
  final int duration;
  final List<String> guests;
  final VoidCallback onConfirm;

  const ReviewConfirmStep({
    super.key,
    required this.eventType,
    required this.venue,
    required this.foodPackage,
    required this.services,
    required this.date,
    required this.time,
    required this.duration,
    required this.guests,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review & Confirm',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Event Summary Card
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getEventIcon(eventType),
                              color: AppColors.primary,
                              size: 32,
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$eventType Celebration',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                  ),
                                  if (date != null)
                                    Text(
                                      DateFormat('MMMM dd, yyyy').format(date!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.darkGrey),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingLarge),

                        // Event Details
                        _buildDetailRow(
                          context,
                          'Venue',
                          venue,
                          Icons.location_on,
                        ),
                        _buildDetailRow(
                          context,
                          'Date',
                          date != null
                              ? DateFormat('MMMM dd, yyyy').format(date!)
                              : 'Not selected',
                          Icons.calendar_today,
                        ),
                        _buildDetailRow(
                          context,
                          'Time',
                          time,
                          Icons.access_time,
                        ),
                        _buildDetailRow(
                          context,
                          'Duration',
                          '$duration hours',
                          Icons.timer,
                        ),
                        _buildDetailRow(
                          context,
                          'Food Package',
                          foodPackage,
                          Icons.restaurant,
                        ),
                        _buildDetailRow(
                          context,
                          'Guests',
                          '${guests.length} people',
                          Icons.people,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppConstants.paddingMedium),

                  // Services Card
                  if (services.isNotEmpty)
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Additional Services',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: AppConstants.paddingMedium),
                          ...services
                              .map(
                                (service) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppConstants.paddingSmall,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _getServiceIcon(service),
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: AppConstants.paddingMedium,
                                      ),
                                      Text(
                                        service,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),

                  const SizedBox(height: AppConstants.paddingMedium),

                  // Cost Breakdown Card
                  CustomCard(
                    backgroundColor: AppColors.lightGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cost Breakdown',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),

                        _buildCostRow(context, 'Venue', '৳20,000'),
                        _buildCostRow(
                          context,
                          'Food Package',
                          _getFoodPackagePrice(foodPackage),
                        ),

                        if (services.isNotEmpty) ...[
                          const SizedBox(height: AppConstants.paddingSmall),
                          Text(
                            'Services:',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          ...services
                              .map(
                                (service) => _buildCostRow(
                                  context,
                                  '  • $service',
                                  _getServicePrice(service),
                                ),
                              )
                              .toList(),
                        ],

                        const Divider(thickness: 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Cost:',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '৳${_calculateTotalCost()}',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontSize: 18,
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
          ),

          const SizedBox(height: AppConstants.paddingMedium),

          // Confirm Button
          CustomButton(
            text: 'Confirm & Pay Advance',
            onPressed: onConfirm,
            width: double.infinity,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(BuildContext context, String item, String cost) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            cost,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
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

  String _getFoodPackagePrice(String package) {
    switch (package) {
      case 'Basic Package':
        return '৳15,000';
      case 'Premium Package':
        return '৳25,000';
      case 'Luxury Package':
        return '৳40,000';
      default:
        return '৳20,000';
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

  String _calculateTotalCost() {
    int total = 20000; // Base venue cost

    // Add food package cost
    switch (foodPackage) {
      case 'Basic Package':
        total += 15000;
        break;
      case 'Premium Package':
        total += 25000;
        break;
      case 'Luxury Package':
        total += 40000;
        break;
      default:
        total += 20000;
    }

    // Add services cost
    for (String service in services) {
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

    return total.toString();
  }
}
