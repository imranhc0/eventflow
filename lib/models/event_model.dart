class EventModel {
  final String id;
  final String title;
  final String type;
  final String venue;
  final String foodPackage;
  final List<String> services;
  final DateTime date;
  final String time;
  final int duration;
  final List<String> guests;
  final String status;
  final double cost;

  EventModel({
    required this.id,
    required this.title,
    required this.type,
    required this.venue,
    required this.foodPackage,
    required this.services,
    required this.date,
    required this.time,
    required this.duration,
    required this.guests,
    required this.status,
    required this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'venue': venue,
      'foodPackage': foodPackage,
      'services': services,
      'date': date.toIso8601String(),
      'time': time,
      'duration': duration,
      'guests': guests,
      'status': status,
      'cost': cost,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      venue: json['venue'],
      foodPackage: json['foodPackage'],
      services: List<String>.from(json['services']),
      date: DateTime.parse(json['date']),
      time: json['time'],
      duration: json['duration'],
      guests: List<String>.from(json['guests']),
      status: json['status'],
      cost: json['cost'].toDouble(),
    );
  }
}
