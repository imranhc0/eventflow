import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class VenueStep extends StatefulWidget {
  final String? selectedVenue;
  final Function(String) onVenueSelected;
  final VoidCallback onNext;

  const VenueStep({
    super.key,
    required this.selectedVenue,
    required this.onVenueSelected,
    required this.onNext,
  });

  @override
  State<VenueStep> createState() => _VenueStepState();
}

class _VenueStepState extends State<VenueStep> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredVenues = AppConstants.venues;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterVenues);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVenues() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredVenues = AppConstants.venues
          .where((venue) => venue.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your perfect venue',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          // Search Bar
          CustomTextField(
            hintText: 'Search venue...',
            controller: _searchController,
            prefixIcon: const Icon(Icons.search),
          ),

          const SizedBox(height: AppConstants.paddingMedium),

          // Venues List
          Expanded(
            child: ListView.builder(
              itemCount: filteredVenues.length,
              itemBuilder: (context, index) {
                final venue = filteredVenues[index];
                final isSelected = widget.selectedVenue == venue;

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.paddingMedium,
                  ),
                  child: CustomCard(
                    backgroundColor: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.white,
                    onTap: () => widget.onVenueSelected(venue),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusSmall,
                                ),
                              ),
                              child: const Icon(
                                Icons.location_city,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    venue,
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
                                    'Perfect for your special event',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.darkGrey),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '4.5 (120 reviews)',
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
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                                size: 24,
                              ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        CustomButton(
                          text: 'Continue to Food Package',
                          onPressed: () {
                            widget.onVenueSelected(venue);
                            widget.onNext();
                          },
                          width: double.infinity,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
