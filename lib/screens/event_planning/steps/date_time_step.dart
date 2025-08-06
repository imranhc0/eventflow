import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class DateTimeStep extends StatefulWidget {
  final DateTime? selectedDate;
  final String? selectedTime;
  final int eventDuration;
  final Function(DateTime) onDateSelected;
  final Function(String) onTimeSelected;
  final Function(int) onDurationChanged;
  final VoidCallback onNext;

  const DateTimeStep({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.eventDuration,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.onDurationChanged,
    required this.onNext,
  });

  @override
  State<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends State<DateTimeStep> {
  final List<String> timeSlots = ['10 AM', '12 PM', '6 PM', '9 PM'];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select date and time',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingLarge),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calendar
                  CustomCard(
                    child: TableCalendar<Event>(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: widget.selectedDate ?? DateTime.now(),
                      selectedDayPredicate: (day) {
                        return widget.selectedDate != null && 
                               isSameDay(widget.selectedDate!, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        widget.onDateSelected(selectedDay);
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: const TextStyle(color: AppColors.primary),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primary),
                        rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primary),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Selected Date Display
                  if (widget.selectedDate != null)
                    CustomCard(
                      backgroundColor: AppColors.lightGrey,
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: AppColors.primary),
                          const SizedBox(width: AppConstants.paddingMedium),
                          Text(
                            'Selected Date: ${DateFormat('MMMM dd, yyyy').format(widget.selectedDate!)}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Time Slots
                  Text(
                    'Select Time',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  Wrap(
                    spacing: AppConstants.paddingMedium,
                    runSpacing: AppConstants.paddingSmall,
                    children: timeSlots.map((time) {
                      final isSelected = widget.selectedTime == time;
                      return GestureDetector(
                        onTap: () => widget.onTimeSelected(time),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingLarge,
                            vertical: AppConstants.paddingMedium,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.grey,
                            ),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected ? AppColors.white : AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  // Duration Slider
                  Text(
                    'Event Duration',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  CustomCard(
                    child: Column(
                      children: [
                        Text(
                          '${widget.eventDuration} hours',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Slider(
                          value: widget.eventDuration.toDouble(),
                          min: 2,
                          max: 12,
                          divisions: 10,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            widget.onDurationChanged(value.round());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('2 hours', style: Theme.of(context).textTheme.bodySmall),
                            Text('12 hours', style: Theme.of(context).textTheme.bodySmall),
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
          
          // Continue Button
          CustomButton(
            text: 'Continue to Guest List',
            onPressed: widget.selectedDate != null && widget.selectedTime != null 
                ? widget.onNext 
                : () {},
            width: double.infinity,
            height: 50,
            backgroundColor: widget.selectedDate != null && widget.selectedTime != null
                ? AppColors.primary 
                : AppColors.grey,
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  
  const Event(this.title);
  
  @override
  String toString() => title;
}
