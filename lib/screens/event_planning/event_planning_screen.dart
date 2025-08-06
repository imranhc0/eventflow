import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import 'steps/event_type_step.dart';
import 'steps/venue_step.dart';
import 'steps/food_package_step.dart';
import 'steps/services_step.dart';
import 'steps/date_time_step.dart';
import 'steps/guest_list_step.dart';
import 'steps/review_confirm_step.dart';

class EventPlanningScreen extends StatefulWidget {
  const EventPlanningScreen({super.key});

  @override
  State<EventPlanningScreen> createState() => _EventPlanningScreenState();
}

class _EventPlanningScreenState extends State<EventPlanningScreen> {
  int _currentStep = 0;

  // Form data
  String? selectedEventType;
  String? selectedVenue;
  String? selectedFoodPackage;
  List<String> selectedServices = [];
  DateTime? selectedDate;
  String? selectedTime;
  int eventDuration = 8;
  List<String> guestList = [];

  final List<String> _stepTitles = [
    'Select Event Type',
    'Choose Venue',
    'Select Food Package',
    'Add Services',
    'Select Date & Time',
    'Guest List',
    'Review & Confirm',
  ];

  void _nextStep() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(_stepTitles[_currentStep]),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 0) {
              _previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              children: List.generate(_stepTitles.length, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? AppColors.primary
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Step Content
          Expanded(child: _buildCurrentStep()),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return EventTypeStep(
          selectedEventType: selectedEventType,
          onEventTypeSelected: (eventType) {
            setState(() {
              selectedEventType = eventType;
            });
          },
          onNext: _nextStep,
        );
      case 1:
        return VenueStep(
          selectedVenue: selectedVenue,
          onVenueSelected: (venue) {
            setState(() {
              selectedVenue = venue;
            });
          },
          onNext: _nextStep,
        );
      case 2:
        return FoodPackageStep(
          selectedFoodPackage: selectedFoodPackage,
          onFoodPackageSelected: (foodPackage) {
            setState(() {
              selectedFoodPackage = foodPackage;
            });
          },
          onNext: _nextStep,
        );
      case 3:
        return ServicesStep(
          selectedServices: selectedServices,
          onServicesChanged: (services) {
            setState(() {
              selectedServices = services;
            });
          },
          onNext: _nextStep,
        );
      case 4:
        return DateTimeStep(
          selectedDate: selectedDate,
          selectedTime: selectedTime,
          eventDuration: eventDuration,
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          onTimeSelected: (time) {
            setState(() {
              selectedTime = time;
            });
          },
          onDurationChanged: (duration) {
            setState(() {
              eventDuration = duration;
            });
          },
          onNext: _nextStep,
        );
      case 5:
        return GuestListStep(
          guestList: guestList,
          onGuestListChanged: (guests) {
            setState(() {
              guestList = guests;
            });
          },
          onNext: _nextStep,
        );
      case 6:
        return ReviewConfirmStep(
          eventType: selectedEventType ?? '',
          venue: selectedVenue ?? '',
          foodPackage: selectedFoodPackage ?? '',
          services: selectedServices,
          date: selectedDate,
          time: selectedTime ?? '',
          duration: eventDuration,
          guests: guestList,
          onConfirm: () {
            // Handle event confirmation
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Event created successfully!'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
        );
      default:
        return const Center(child: Text('Invalid step'));
    }
  }
}
