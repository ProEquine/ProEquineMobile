import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'local_horse.g.dart';


@HiveType(typeId: 0)
class Horse extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String horseName;

  @HiveField(2)
  late DateTime shippingEstimatedDate;

  @HiveField(3)
  late String pickupLocation;

  @HiveField(4)
  late String pickupContactName;

  @HiveField(5)
  late String pickupContactNumber;

  @HiveField(6)
  late bool equipmentTask;

  @HiveField(7)
  late String numberOfHorses;

  @HiveField(8)
  late String note;

  @HiveField(9)
  late String exportingCountry;

  @HiveField(10)
  late String horseGender;

  @HiveField(11)
  late String ownerShip;

  @HiveField(12)
  late String staying;

  @HiveField(13)
  late String color;

  @HiveField(14)
  late String bloodLine;

  @HiveField(15)
  late String breed;

  @HiveField(16)
  late String discipline;

  @HiveField(17)
  late bool isNewHorse;


  Horse({
    required this.id,
    required this.shippingEstimatedDate,
    required this.exportingCountry,
    required this.pickupLocation,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.equipmentTask,
    required this.numberOfHorses,
    required this.note,
    required this.horseName,
    required this.horseGender,
    required this.ownerShip,
    required this.staying,
    required this.color,
    required this.breed,
    required this.bloodLine,
    required this.discipline,
    required this.isNewHorse,
  });
}

