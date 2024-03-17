import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonapp/provider/base.dart';
import 'package:logger/logger.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'helpers/path_map.dart';
import 'models/agregate.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListPage> createState() => _ListPage();
}

class _ListPage extends ConsumerState<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    List<int> currentPath = ref.watch(pathProvider) ?? [];
    final List<dynamic> currentTargetPath = currentPath.isEmpty
        ? ['childLocations']
        : currentPath.fold(
            [],
            (previousValue, element) =>
                [...previousValue, 'childLocations', element]);
    logger.d('currentPath $currentPath');
    logger.d('currentTargetPath $currentTargetPath');
    logger.d('aggr map $ref.watch(dataProvider.notifier).state');
    logger.d(selectMapPath(
        (ref.watch(dataProvider.notifier).state?.toMap()), currentTargetPath));
    final Aggregate? currentTargetLocationList = currentPath.isEmpty
        ? ref.watch(dataProvider.notifier).state
        : selectMapPath(
            ref.watch(dataProvider.notifier).state, currentTargetPath);
    final totalItemsInLocation =
        currentTargetLocationList?.totalItemsInLocation ?? 0;
    final childLocationsCount =
        currentTargetLocationList?.childLocationsCount ?? 0;
    final totalUnitsInLocation =
        currentTargetLocationList?.totalUnitsInLocation ?? 0;
    final items = currentTargetLocationList?.items ?? [];
    final locations = currentTargetLocationList?.childLocations ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              MultiSliver(pushPinnedChildren: true, children: <Widget>[
                SliverPinnedHeader(
                    child: Container(
                        color: Colors.grey,
                        height: 70,
                        child: Row(children: [
                          Text('$totalItemsInLocation loc |',
                              style: const TextStyle(fontSize: 30)),
                          Text('$childLocationsCount unt |',
                              style: const TextStyle(fontSize: 30)),
                          Text('$totalUnitsInLocation itm |',
                              style: const TextStyle(fontSize: 30))
                        ]))),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: locations.length,
                    (BuildContext context, int index) {
                      final currentLoc = locations[index];

                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () => {
                            logger.d(currentLoc.path),
                            ref.read(pathProvider.notifier).state =
                                currentLoc.path
                          },
                          child: Container(
                            color: Colors.greenAccent,
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              currentLoc.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }, // 40 list items
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: items.length,
                    (BuildContext context, int index) {
                      final currentItem = items[index];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          color: Colors.cyan,
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            currentItem.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }, // 40 list items
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
