import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class GuestListStep extends StatefulWidget {
  final List<String> guestList;
  final Function(List<String>) onGuestListChanged;
  final VoidCallback onNext;

  const GuestListStep({
    super.key,
    required this.guestList,
    required this.onGuestListChanged,
    required this.onNext,
  });

  @override
  State<GuestListStep> createState() => _GuestListStepState();
}

class _GuestListStepState extends State<GuestListStep> {
  final TextEditingController _guestController = TextEditingController();
  bool _showAddForm = false;

  @override
  void dispose() {
    _guestController.dispose();
    super.dispose();
  }

  void _addGuest() {
    if (_guestController.text.trim().isNotEmpty) {
      final updatedList = List<String>.from(widget.guestList);
      updatedList.add(_guestController.text.trim());
      widget.onGuestListChanged(updatedList);
      _guestController.clear();
      setState(() {
        _showAddForm = false;
      });
    }
  }

  void _removeGuest(int index) {
    final updatedList = List<String>.from(widget.guestList);
    updatedList.removeAt(index);
    widget.onGuestListChanged(updatedList);
  }

  void _importFromContacts() {
    // Simulate importing contacts
    final sampleGuests = ['John Smith', 'Sarah Johnson', 'Michael Brown'];
    final updatedList = List<String>.from(widget.guestList);
    for (String guest in sampleGuests) {
      if (!updatedList.contains(guest)) {
        updatedList.add(guest);
      }
    }
    widget.onGuestListChanged(updatedList);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sample guests imported successfully!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage your guest list',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Import from Contacts',
                  onPressed: _importFromContacts,
                  isOutlined: true,
                  height: 50,
                ),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: CustomButton(
                  text: 'Add Manually',
                  onPressed: () {
                    setState(() {
                      _showAddForm = !_showAddForm;
                    });
                  },
                  height: 50,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.paddingMedium),

          // Add Guest Form
          if (_showAddForm)
            CustomCard(
              backgroundColor: AppColors.lightGrey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Enter guest name',
                    controller: _guestController,
                    prefixIcon: const Icon(Icons.person_add),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Cancel',
                          onPressed: () {
                            setState(() {
                              _showAddForm = false;
                              _guestController.clear();
                            });
                          },
                          isOutlined: true,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingMedium),
                      Expanded(
                        child: CustomButton(
                          text: 'Add Guest',
                          onPressed: _addGuest,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppConstants.paddingMedium),

          // Guest Count
          Text(
            'Guests (${widget.guestList.length})',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: AppConstants.paddingMedium),

          // Guest List
          Expanded(
            child: widget.guestList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: AppColors.grey,
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Text(
                          'No guests added yet',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: AppConstants.paddingSmall),
                        Text(
                          'Add guests manually or import from contacts',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.guestList.length,
                    itemBuilder: (context, index) {
                      final guest = widget.guestList[index];
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: AppConstants.paddingSmall,
                        ),
                        child: CustomCard(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Text(
                                  guest.isNotEmpty
                                      ? guest[0].toUpperCase()
                                      : 'G',
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppConstants.paddingMedium),
                              Expanded(
                                child: Text(
                                  guest,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeGuest(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Continue Button
          CustomButton(
            text: 'Continue to Review',
            onPressed: widget.onNext,
            width: double.infinity,
            height: 50,
          ),
        ],
      ),
    );
  }
}
