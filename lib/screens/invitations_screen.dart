import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../models/guest_model.dart';

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({super.key});

  @override
  State<InvitationsScreen> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  // Sample invitations data
  final List<Map<String, dynamic>> _invitations = [
    {
      'eventTitle': 'Wedding Celebration',
      'eventType': 'Wedding',
      'eventDate': DateTime(2024, 3, 15),
      'venue': 'Grand Palace',
      'guests': [
        GuestModel(
          id: '1',
          name: 'John Smith',
          email: 'john.smith@email.com',
          phone: '+1 (555) 123-4567',
          status: 'Accepted',
        ),
        GuestModel(
          id: '2',
          name: 'Emily Johnson',
          email: 'emily.johnson@email.com',
          phone: '+1 (555) 234-5678',
          status: 'Pending',
        ),
        GuestModel(
          id: '3',
          name: 'Michael Brown',
          email: 'michael.brown@email.com',
          phone: '+1 (555) 345-6789',
          status: 'Declined',
        ),
      ],
    },
    {
      'eventTitle': 'Birthday Party',
      'eventType': 'Birthday',
      'eventDate': DateTime(2024, 1, 20),
      'venue': 'Garden Paradise',
      'guests': [
        GuestModel(
          id: '4',
          name: 'Sarah Wilson',
          email: 'sarah.wilson@email.com',
          phone: '+1 (555) 456-7890',
          status: 'Accepted',
        ),
        GuestModel(
          id: '5',
          name: 'David Lee',
          email: 'david.lee@email.com',
          phone: '+1 (555) 567-8901',
          status: 'Accepted',
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Invitations'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _invitations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: _invitations.length,
              itemBuilder: (context, index) {
                final invitation = _invitations[index];
                final guests = invitation['guests'] as List<GuestModel>;

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.paddingLarge,
                  ),
                  child: CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusSmall,
                                ),
                              ),
                              child: Icon(
                                _getEventIcon(invitation['eventType']),
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
                                    invitation['eventTitle'],
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat(
                                          'MMM dd, yyyy',
                                        ).format(invitation['eventDate']),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.darkGrey,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: AppConstants.paddingMedium,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        invitation['venue'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.darkGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingLarge),

                        // RSVP Summary
                        Row(children: [_buildRSVPSummary(guests)]),

                        const SizedBox(height: AppConstants.paddingMedium),

                        // Guest List
                        Text(
                          'Guest List (${guests.length})',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: AppConstants.paddingMedium),

                        ...guests.map(
                          (guest) => Container(
                            margin: const EdgeInsets.only(
                              bottom: AppConstants.paddingSmall,
                            ),
                            padding: const EdgeInsets.all(
                              AppConstants.paddingMedium,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusSmall,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: _getStatusColor(
                                    guest.status,
                                  ),
                                  radius: 20,
                                  child: Text(
                                    guest.name.isNotEmpty
                                        ? guest.name[0].toUpperCase()
                                        : 'G',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: AppConstants.paddingMedium,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        guest.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        guest.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.darkGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                _buildStatusChip(guest.status),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: AppConstants.paddingMedium),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Send Reminder',
                                onPressed: () =>
                                    _sendReminder(invitation['eventTitle']),
                                isOutlined: true,
                                height: 40,
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: CustomButton(
                                text: 'View Details',
                                onPressed: () => _viewEventDetails(invitation),
                                height: 40,
                              ),
                            ),
                          ],
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
            Icon(Icons.inbox, size: 80, color: AppColors.grey),
            const SizedBox(height: AppConstants.paddingLarge),
            Text(
              'No Invitations',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(
              'Your event invitations will appear here',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRSVPSummary(List<GuestModel> guests) {
    final accepted = guests.where((g) => g.status == 'Accepted').length;
    final pending = guests.where((g) => g.status == 'Pending').length;
    final declined = guests.where((g) => g.status == 'Declined').length;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRSVPCount('Accepted', accepted, Colors.green),
          _buildRSVPCount('Pending', pending, Colors.orange),
          _buildRSVPCount('Declined', declined, Colors.red),
        ],
      ),
    );
  }

  Widget _buildRSVPCount(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.darkGrey),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'accepted':
        backgroundColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        break;
      case 'declined':
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'declined':
        return Colors.red;
      default:
        return AppColors.grey;
    }
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

  void _sendReminder(String eventTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder sent for $eventTitle'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _viewEventDetails(Map<String, dynamic> invitation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        minChildSize: 0.4,
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
                      Text(
                        invitation['eventTitle'],
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: AppConstants.paddingMedium),

                      _buildDetailRow(
                        'Type',
                        invitation['eventType'],
                        Icons.category,
                      ),
                      _buildDetailRow(
                        'Venue',
                        invitation['venue'],
                        Icons.location_on,
                      ),
                      _buildDetailRow(
                        'Date',
                        DateFormat(
                          'MMMM dd, yyyy',
                        ).format(invitation['eventDate']),
                        Icons.calendar_today,
                      ),

                      const SizedBox(height: AppConstants.paddingMedium),

                      Text(
                        'Guest Responses',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: AppConstants.paddingMedium),

                      _buildRSVPSummary(
                        invitation['guests'] as List<GuestModel>,
                      ),
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
