// To parse this JSON data, do
//
//     final aggregate = aggregateFromMap(jsonString);

import 'dart:convert';

Aggregate aggregateFromMap(String str) => Aggregate.fromMap(json.decode(str));

String aggregateToMap(Aggregate data) => json.encode(data.toMap());

class Aggregate {
  String name;
  int totalItemsInLocation;
  int totalUnitsInLocation;
  int childLocationsCount;
  List<Item> items;
  List<Aggregate> childLocations;

  Aggregate({
    required this.name,
    required this.totalItemsInLocation,
    required this.totalUnitsInLocation,
    required this.childLocationsCount,
    required this.items,
    required this.childLocations,
  });

  Aggregate copyWith({
    String? name,
    int? totalItemsInLocation,
    int? totalUnitsInLocation,
    int? childLocationsCount,
    List<Item>? items,
    List<Aggregate>? childLocations,
  }) =>
      Aggregate(
        name: name ?? this.name,
        totalItemsInLocation: totalItemsInLocation ?? this.totalItemsInLocation,
        totalUnitsInLocation: totalUnitsInLocation ?? this.totalUnitsInLocation,
        childLocationsCount: childLocationsCount ?? this.childLocationsCount,
        items: items ?? this.items,
        childLocations: childLocations ?? this.childLocations,
      );

  factory Aggregate.fromMap(Map<String, dynamic> json) => Aggregate(
        name: json["name"],
        totalItemsInLocation: json["totalItemsInLocation"],
        totalUnitsInLocation: json["totalUnitsInLocation"],
        childLocationsCount: json["childLocationsCount"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        childLocations: List<Aggregate>.from(
            json["childLocations"].map((x) => Aggregate.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "totalItemsInLocation": totalItemsInLocation,
        "totalUnitsInLocation": totalUnitsInLocation,
        "childLocationsCount": childLocationsCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "childLocations":
            List<dynamic>.from(childLocations.map((x) => x.toMap())),
      };
}

class Item {
  String name;
  String barcode;
  String location;
  int quantity;

  Item({
    required this.name,
    required this.barcode,
    required this.location,
    required this.quantity,
  });

  Item copyWith({
    String? name,
    String? barcode,
    String? location,
    int? quantity,
  }) =>
      Item(
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        location: location ?? this.location,
        quantity: quantity ?? this.quantity,
      );

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        name: json["name"],
        barcode: json["barcode"],
        location: json["location"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "barcode": barcode,
        "location": location,
        "quantity": quantity,
      };
}
