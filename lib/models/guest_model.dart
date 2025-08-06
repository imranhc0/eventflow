class GuestModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status; // 'Accepted', 'Pending', 'Declined'

  GuestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
    };
  }

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
    );
  }
}
