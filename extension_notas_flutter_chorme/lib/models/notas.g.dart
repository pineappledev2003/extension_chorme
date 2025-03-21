// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotasAdapter extends TypeAdapter<Notas> {
  @override
  final int typeId = 0;

  @override
  Notas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notas(
      fechaCreacion: fields[0] as DateTime,  
      tituloNota: fields[1] as String,       
      descripcionNota: fields[2] as String, 
    );
      
  }

  @override
  void write(BinaryWriter writer, Notas obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._fechaCreacion)
      ..writeByte(1)
      ..write(obj._tituloNota)
      ..writeByte(2)
      ..write(obj._descripcionNota);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
