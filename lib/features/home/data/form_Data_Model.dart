class FromDataModel {
  String origin;
  String destination;
  String contact;
  String? comment;
  String date;
  String? expectedDate;
  String? tripType;
  String? numberOfHorses;
  String? time;
  String? expectedTime;

  FromDataModel({
    required this.origin,
    required this.destination,
    required this.contact,
    this.comment,
    required this.date,
    this.expectedDate,
    required this.tripType,
    required this.numberOfHorses,
    required this.time,
    required this.expectedTime,
  });
}
