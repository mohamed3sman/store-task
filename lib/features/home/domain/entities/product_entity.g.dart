// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 0;

  @override
  ProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductEntity(
      isFavourite: fields[10] as bool?,
      brand: fields[6] as String?,
      model: fields[7] as String?,
      color: fields[8] as String?,
      discount: fields[9] as num?,
      id: fields[0] as int?,
      title: fields[1] as String?,
      price: fields[2] as int?,
      description: fields[3] as String?,
      category: fields[4] as String?,
      images: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.brand)
      ..writeByte(7)
      ..write(obj.model)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.discount)
      ..writeByte(10)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
