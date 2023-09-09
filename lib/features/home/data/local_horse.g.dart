// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_horse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HorseAdapter extends TypeAdapter<Horse> {
  @override
  final int typeId = 0;

  @override
  Horse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Horse(
      id: fields[0] as String,
      shippingEstimatedDate: fields[2] as DateTime,
      exportingCountry: fields[9] as String,
      pickupLocation: fields[3] as String,
      pickupContactName: fields[4] as String,
      pickupContactNumber: fields[5] as String,
      equipmentTask: fields[6] as bool,
      numberOfHorses: fields[7] as String,
      note: fields[8] as String,
      horseName: fields[1] as String,
      horseGender: fields[10] as String,
      ownerShip: fields[11] as String,
      staying: fields[12] as String,
      color: fields[13] as String,
      breed: fields[15] as String,
      bloodLine: fields[14] as String,
      discipline: fields[16] as String,
      isNewHorse: fields[17] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Horse obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.horseName)
      ..writeByte(2)
      ..write(obj.shippingEstimatedDate)
      ..writeByte(3)
      ..write(obj.pickupLocation)
      ..writeByte(4)
      ..write(obj.pickupContactName)
      ..writeByte(5)
      ..write(obj.pickupContactNumber)
      ..writeByte(6)
      ..write(obj.equipmentTask)
      ..writeByte(7)
      ..write(obj.numberOfHorses)
      ..writeByte(8)
      ..write(obj.note)
      ..writeByte(9)
      ..write(obj.exportingCountry)
      ..writeByte(10)
      ..write(obj.horseGender)
      ..writeByte(11)
      ..write(obj.ownerShip)
      ..writeByte(12)
      ..write(obj.staying)
      ..writeByte(13)
      ..write(obj.color)
      ..writeByte(14)
      ..write(obj.bloodLine)
      ..writeByte(15)
      ..write(obj.breed)
      ..writeByte(16)
      ..write(obj.discipline)
      ..writeByte(17)
      ..write(obj.isNewHorse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
