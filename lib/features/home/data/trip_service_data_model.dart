class TripServiceDataModel {
  String pickupLocation;
  String tripType;
  String trip;
  String pickupDate;
  String pickupTime;
  String pickupContactName;
  String pickupContactNumber;
  String? dropLocation;
  String dropContactNumber;
  String dropContactName;
  String? hospitalName;
  String horsesNumber;
  String? expectedDate;
  String? expectedTime;

  TripServiceDataModel({
    required this.pickupLocation,
    required this.tripType,
    required this.trip,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropContactName,
    required this.dropContactNumber,
    this.dropLocation,
    this.hospitalName,
    required this.horsesNumber,
    this.expectedDate,
    this.expectedTime,
  });
}
