class EventRequestModel {
  late String origin;
  late String eventLocation;
  late String eventTitle;
  late String noofhorse;
  late DateTime datetime;
  late String triptype;
  late DateTime? returndate;

  EventRequestModel({
    required this.origin,
    required this.eventLocation,
    required this.eventTitle,
    required this.noofhorse,
    required this.datetime,
    required this.triptype,
    this.returndate,
  });
}
