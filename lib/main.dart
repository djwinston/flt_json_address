import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonapp/provider/base.dart';

import 'list_page.dart';
import 'models/agregate.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const MyHomePage(),
        '/details': (BuildContext context) => const ListPage(),
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> loadJsonAsset() async {
      final String jsonString = await rootBundle.loadString('mock/data.json');
      final data = aggregateFromMap(jsonString);
      ref.read(dataProvider.notifier).state = data;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('totalUnitsInLocation:'),
              Consumer(
                builder: (context, ref, _) {
                  final totalUnitsInLocation =
                      ref.watch(dataProvider)?.totalUnitsInLocation ?? 0;

                  return Text(
                    '$totalUnitsInLocation',
                    key: const Key('counterState'),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              const Text('totalItemsInLocation:'),
              Consumer(
                builder: (context, ref, _) {
                  final totalItemsInLocation =
                      ref.watch(dataProvider)?.totalItemsInLocation ?? 0;

                  return Text(
                    '$totalItemsInLocation',
                    key: const Key('counterState'),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              const Text('childLocationsCount:'),
              Consumer(
                builder: (context, ref, _) {
                  final childLocationsCount =
                      ref.watch(dataProvider)?.childLocationsCount ?? 0;
                  return Text(
                    '$childLocationsCount',
                    key: const Key('counterState'),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              TextButton(
                  onPressed: () => loadJsonAsset(), child: const Text('Load'))
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  heroTag: 'add',
                  child: const Icon(Icons.navigate_next),
                  onPressed: () {
                    Navigator.pushNamed(context, '/details');
                  }),
            )
          ],
        ));
  }
}
