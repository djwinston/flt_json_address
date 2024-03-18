import '../models/agregate.dart';

dynamic selectMapPath(dynamic map, List<dynamic> path) {
  var result = map;

  final pathOk = path.every((key) {
    if (map is! Map<String, dynamic> && map is! List<dynamic>) {
      return false;
    }
    if (key is int && (result is! List<dynamic> || key > result.length - 1)) {
      return false;
    }
    if (result[key] != null) {
      result = result[key];
      return true;
    }
    return false;
  });

  if (!pathOk) {
    return null;
  }

  return result;
}

enum DataType { childLocations, items }

Aggregate? selectMapbyPath(Aggregate map, List<int> path) {
  var result = map;
  bool isPath;

  isPath = path.every((key) {
    if (key > map.childLocations.length - 1) {
      return false;
    } else {
      final Aggregate item = result.childLocations[key];
      result = item;
      return true;
    }
  });

  return isPath ? result : null;
}
