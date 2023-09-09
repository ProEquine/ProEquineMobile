class ShippingServiceModel {
  String pickupLocation;
  DateTime shipmentEstimatedDate;
  String pickupContactName;
  String pickupContactNumber;
  String selectedCountry;
  String horsesNumber;
  String serviceType;
  String? notes;
  bool isThereAreEquipment;

  ShippingServiceModel({
    required this.pickupLocation,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.shipmentEstimatedDate,
    required this.selectedCountry,
    required this.horsesNumber,
    required this.serviceType,
    this.notes,
    this.isThereAreEquipment=false,
  });
}
