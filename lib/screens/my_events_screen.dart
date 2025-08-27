import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../models/event_model.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  // Sample events data
  final List<EventModel> _events = [
    EventModel(
      id: '1',
      title: 'Wedding Celebration',
      type: 'Wedding',
      venue: 'Grand Palace',
      foodPackage: 'Luxury Package',
      services: ['Photography', 'Videography', 'Decor'],
      date: DateTime(2024, 3, 15),
      time: '6 PM',
      duration: 8,
      guests: ['John Smith', 'Emily Johnson', 'Michael Brown'],
      status: 'Ongoing',
      cost: 63740,
    ),
    EventModel(
      id: '2',
      title: 'Birthday Party',
      type: 'Birthday',
      venue: 'Garden Paradise',
      foodPackage: 'Premium Package',
      services: ['Photography', 'Music/DJ'],
      date: DateTime(2024, 1, 20),
      time: '12 PM',
      duration: 6,
      guests: ['Sarah Wilson', 'David Lee'],
      status: 'Completed',
      cost: 42000,
    ),
    EventModel(
      id: '3',
      title: 'Corporate Meeting',
      type: 'Corporate',
      venue: 'Royal Banquet',
      foodPackage: 'Basic Package',
      services: ['Guest Handling'],
      date: DateTime(2024, 4, 10),
      time: '10 AM',
      duration: 4,
      guests: ['Team Members'],
      status: 'Upcoming',
      cost: 25000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('My Events'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.eventPlanning);
            },
          ),
        ],
      ),
      body: _events.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.paddingMedium,
                  ),
                  child: CustomCard(
                    onTap: () => _showEventDetails(context, event),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusSmall,
                                ),
                              ),
                              child: Icon(
                                _getEventIcon(event.type),
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.type,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.darkGrey),
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusChip(event.status),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingMedium),

                        // Event Details
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.venue,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.darkGrey),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM dd, yyyy').format(event.date),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.darkGrey),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingSmall),

                        Row(
                          children: [
                            Icon(Icons.people, size: 16, color: AppColors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${event.guests.length} guests',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.darkGrey),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Icon(
                              Icons.currency_rupee,
                              size: 16,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '৳${event.cost.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingMedium),

                        // Action Button
                        CustomButton(
                          text: 'View Details',
                          onPressed: () => _showEventDetails(context, event),
                          width: double.infinity,
                          height: 40,
                          isOutlined: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_note, size: 80, color: AppColors.grey),
            const SizedBox(height: AppConstants.paddingLarge),
            Text(
              'No Events Yet',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Start planning your first event to see it here',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            CustomButton(
              text: 'Plan Your First Event',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.eventPlanning);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'ongoing':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'completed':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'upcoming':
        backgroundColor = AppColors.primary.withOpacity(0.1);
        textColor = AppColors.primary;
        break;
      default:
        backgroundColor = AppColors.lightGrey;
        textColor = AppColors.darkGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
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

  void _showEventDetails(BuildContext context, EventModel event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Title
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: AppConstants.paddingMedium),

                      // Event Details
                      _buildDetailRow('Type', event.type, Icons.category),
                      _buildDetailRow('Venue', event.venue, Icons.location_on),
                      _buildDetailRow(
                        'Date',
                        DateFormat('MMMM dd, yyyy').format(event.date),
                        Icons.calendar_today,
                      ),
                      _buildDetailRow('Time', event.time, Icons.access_time),
                      _buildDetailRow(
                        'Duration',
                        '${event.duration} hours',
                        Icons.timer,
                      ),
                      _buildDetailRow(
                        'Food Package',
                        event.foodPackage,
                        Icons.restaurant,
                      ),
                      _buildDetailRow(
                        'Guests',
                        '${event.guests.length} people',
                        Icons.people,
                      ),
                      _buildDetailRow('Status', event.status, Icons.info),
                      _buildDetailRow(
                        'Total Cost',
                        '৳${event.cost.toStringAsFixed(0)}',
                        Icons.currency_rupee,
                      ),

                      if (event.services.isNotEmpty) ...[
                        const SizedBox(height: AppConstants.paddingMedium),
                        Text(
                          'Services',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        ...event.services
                            .map(
                              (service) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 8),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppConstants.paddingMedium),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
