class HolidayModel {
  final String date;
  final String name;
  final String type;

  HolidayModel({required this.date, required this.name, required this.type});

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json['date'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
