import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonapp/provider/base.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'helpers/path_map.dart';
import 'models/agregate.dart';

class DataPage extends ConsumerStatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DataPage> createState() => _DataPage();
}

class _DataPage extends ConsumerState<DataPage> {
  late Aggregate jsonData;
  final logger = Logger();
  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('mock/data.json');
    final data = aggregateFromMap(jsonString);
    ref.read(dataProvider.notifier).state = data;
    setState(() {
      jsonData = data;
    });
    final path = selectMapPath(jsonData.toMap(), [
          'childLocations',
          0,
          'childLocations',
          1,
          'childLocations',
          0,
          'childLocations',
          0,
          'childLocations',
          0
        ]) ??
        'lol';
    logger.d(path);
    logger
        .d(jsonData.childLocations[0].childLocations[1].childLocations[0].path);
  }

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Placeholder()]),
      ),
    );
  }
}
