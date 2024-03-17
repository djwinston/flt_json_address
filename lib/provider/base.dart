import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/agregate.dart';

/// Providers are declared globally and specify how to create a state
// final counterProvider = StateProvider((ref) => 0);

final dataProvider = StateProvider<Aggregate?>((ref) => null);
final pathProvider = StateProvider<List<int>?>((ref) => []);
