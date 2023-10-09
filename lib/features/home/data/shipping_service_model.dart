class ShippingServiceModel {
  String pickupLocation;
  DateTime shipmentEstimatedDate;
  String pickupContactName;
  String tripId;
  String pickupContactNumber;
  String selectedCountry;
  String horsesNumber;
  String serviceType;
  String? notes;
  String? equipment;

  ShippingServiceModel({
    required this.pickupLocation,
    required this.pickupContactName,
    required this.tripId,
    required this.pickupContactNumber,
    required this.shipmentEstimatedDate,
    required this.selectedCountry,
    required this.horsesNumber,
    required this.serviceType,
    this.notes,
   this.equipment,
  });
}
