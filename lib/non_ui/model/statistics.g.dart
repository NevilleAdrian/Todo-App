// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetCountriesStatisticsAdapter
    extends TypeAdapter<GetCountriesStatistics> {
  @override
  final int typeId = 1;

  @override
  GetCountriesStatistics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetCountriesStatistics(
      continent: fields[0] as String,
      country: fields[1] as String,
      population: fields[2] as int,
      cases: fields[3] as Cases,
    );
  }

  @override
  void write(BinaryWriter writer, GetCountriesStatistics obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.continent)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.population)
      ..writeByte(3)
      ..write(obj.cases);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCountriesStatisticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CasesAdapter extends TypeAdapter<Cases> {
  @override
  final int typeId = 2;

  @override
  Cases read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cases(
      casesNew: fields[0] as String,
      active: fields[1] as int,
      critical: fields[2] as int,
      recovered: fields[3] as int,
      the1MPop: fields[4] as String,
      total: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Cases obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.casesNew)
      ..writeByte(1)
      ..write(obj.active)
      ..writeByte(2)
      ..write(obj.critical)
      ..writeByte(3)
      ..write(obj.recovered)
      ..writeByte(4)
      ..write(obj.the1MPop)
      ..writeByte(5)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CasesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
