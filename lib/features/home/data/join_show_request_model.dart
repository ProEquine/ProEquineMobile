class JoinShowTransportRequestModel {
  String pickupLocation;
  String tripType;
  String trip;
  DateTime pickupDate;
  String showingDate;
  String pickupTime;
  String pickupContactName;
  String pickupContactNumber;
  String horsesNumber;

  JoinShowTransportRequestModel({
    required this.pickupLocation,
    required this.tripType,
    required this.trip,
    required this.showingDate,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.horsesNumber,
  });
}
