class HospitalModel {
  late String origin;
  late String destination;
  late String noofhorse;
  late String triptype;
  late DateTime datetime;
  late DateTime? returndate;

  HospitalModel({
    required this.origin,
    required this.destination,
    required this.noofhorse,
    required this.datetime,
    required this.triptype,
    this.returndate,
  });
}
