import 'dart:convert';
import 'dart:core';

class Product {
  Product({
    required this.imageUrl,
    required this.doors,
    required this.color,
    required this.type,
    required this.passengerCapacity,
    required this.owner,
    required this.make,
    required this.model,
    required this.manufacturingYear,
    required this.plateNumber,
    required this.active,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imageUrl: map['imageUrl'] as String,
      doors: map['doors'] as String,
      color: map['color'] as String,
      type: map['type'] as String,
      passengerCapacity: map['passengerCapacity'] as int,
      owner: map['owner'] as String,
      make: map['make'] as String,
      model: map['model'] as String,
      manufacturingYear: map['manufacturingYear'] as String,
      plateNumber: map['plateNumber'] as String,
      active: map['active'] as bool
    );
  }

  String toJson() => json.encode(toMap());

  // ignore: sort_constructors_first
  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(imageUrl: $imageUrl, doors: $doors, color: $color, type: $type, passengerCapacity: $passengerCapacity, owner: $owner, make: $make, model: $model, manufacturingYear: $manufacturingYear, plateNumber: $plateNumber)';
  }


  Product copyWith({
    String? imageUrl,
    String? doors,
    String? color,
    String? type,
    int? passengerCapacity,
    String? owner,
    String? make,
    String? model,
    String? manufacturingYear,
    String? plateNumber,
    bool? active,
  }) {
    return Product(
      imageUrl: imageUrl ?? this.imageUrl,
      doors: doors ?? this.doors,
      color: color ?? this.color,
      type: type ?? this.type,
      passengerCapacity: passengerCapacity ?? this.passengerCapacity,
      owner: owner ?? this.owner,
      make: make ?? this.make,
      model: model ?? this.model,
      manufacturingYear: manufacturingYear ?? this.manufacturingYear,
      plateNumber: plateNumber ?? this.plateNumber,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'doors': doors,
      'color': color,
      'type': type,
      'passengerCapacity': passengerCapacity,
      'owner': owner,
      'make': make,
      'model': model,
      'manufacturingYear': manufacturingYear,
      'plateNumber': plateNumber,
      'active': active,
    };
  }



  final String imageUrl;
  final String doors;
  final String color;
  final String type;
  final int passengerCapacity;
  final String owner;
  final String make;
  final String model;
  final String manufacturingYear;
  final String plateNumber;
  final bool active;
}
