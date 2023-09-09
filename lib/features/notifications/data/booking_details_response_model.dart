class BookingDetailsResponseModel{
  String pickupLocation;
  String tripType;
  String tripStatus;
  String pickupDate;
  String pickupTime;
  String pickupContactName;
  String pickupContactNumber;
  String dropLocation;
  String dropContactNumber;
  String dropContactName;
  String horsesNumber;
  String? expectedDate;
  String? expectedTime;
  String subtotal;
  String tax;
  String total;
  String bookingId;

  BookingDetailsResponseModel({
    required this.pickupLocation,
    required this.tripType,
    required this.tripStatus,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropContactName,
    required this.dropContactNumber,
    required this.dropLocation,
    required this.horsesNumber,
    this.expectedDate,
    this.expectedTime,
    required this.total,
    required this.subtotal,
    required this.bookingId,
    required this.tax,
  });
}