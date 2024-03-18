// To parse this JSON data, do
//
//     final aggregate = aggregateFromMap(jsonString);

import 'dart:convert';

enum Sum { totalItemsInLocation, totalUnitsInLocation, childLocationsCount }

Aggregate aggregateFromMap(String str) =>
    Aggregate.fromMap(json.decode(str), []);

String aggregateToMap(Aggregate data) => json.encode(data.toMap());

class Aggregate {
  String name;
  int totalItemsInLocation;
  int totalUnitsInLocation;
  int childLocationsCount;
  List<int> path;
  List<Item> items;
  List<Aggregate> childLocations;

  Aggregate({
    required this.name,
    required this.totalItemsInLocation,
    required this.totalUnitsInLocation,
    required this.childLocationsCount,
    required this.path,
    required this.items,
    required this.childLocations,
  });

  Aggregate copyWith({
    String? name,
    int? totalItemsInLocation,
    int? totalUnitsInLocation,
    int? childLocationsCount,
    List<int>? path,
    List<Item>? items,
    List<Aggregate>? childLocations,
  }) =>
      Aggregate(
        name: name ?? this.name,
        totalItemsInLocation: totalItemsInLocation ?? this.totalItemsInLocation,
        totalUnitsInLocation: totalUnitsInLocation ?? this.totalUnitsInLocation,
        childLocationsCount: childLocationsCount ?? this.childLocationsCount,
        path: path ?? this.path,
        items: items ?? this.items,
        childLocations: childLocations ?? this.childLocations,
      );

  factory Aggregate.fromMap(Map<String, dynamic> json, List<int>? path) {
    final currentPath = path ?? [];
    return Aggregate(
      name: json["name"],
      totalItemsInLocation: json["totalItemsInLocation"],
      totalUnitsInLocation: json["totalUnitsInLocation"],
      childLocationsCount: json["childLocationsCount"],
      path: currentPath,
      items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      childLocations: (json['childLocations'] as List<dynamic>)
          .asMap()
          .entries
          .map((el) => Aggregate.fromMap(el.value, [...currentPath, el.key]))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "totalItemsInLocation": totalItemsInLocation,
        "totalUnitsInLocation": totalUnitsInLocation,
        "childLocationsCount": childLocationsCount,
        "path": List<int>.from(path!.map((e) => e)),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "childLocations":
            List<dynamic>.from(childLocations.map((x) => x.toMap())),
      };

  // Map<Sum, int> get summary {
  //   var gifts = Map<Sum, int>();
  //   gifts[Sum.totalItemsInLocation] = totalItemsInLocation;
  //   gifts[Sum.totalUnitsInLocation] = totalUnitsInLocation;
  //   gifts[Sum.childLocationsCount] = childLocationsCount;
  //   return gifts;
  // }
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
