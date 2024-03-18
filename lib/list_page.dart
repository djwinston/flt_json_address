import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsonapp/provider/base.dart';
// import 'package:logger/logger.dart';
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

  final TextEditingController? editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final logger = Logger();
    List<int> currentPath = ref.watch(pathProvider) ?? [];
    final Aggregate? currentTargetLocationList = currentPath.isEmpty
        ? ref.watch(dataProvider.notifier).state
        : selectMapbyPath(ref.watch(dataProvider.notifier).state!, currentPath);

    final totalItemsInLocation =
        currentTargetLocationList?.totalItemsInLocation ?? 0;
    final childLocationsCount =
        currentTargetLocationList?.childLocationsCount ?? 0;
    final totalUnitsInLocation =
        currentTargetLocationList?.totalUnitsInLocation ?? 0;
    final items = currentTargetLocationList?.items ?? [];
    final locations = currentTargetLocationList?.childLocations ?? [];
    final title = currentTargetLocationList != null &&
            currentTargetLocationList.name.isNotEmpty
        ? currentTargetLocationList.name
        : 'Root';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            if (currentPath.isEmpty) {
              Navigator.pushNamed(context, '/');
            } else {
              currentPath.removeLast();
              ref.read(pathProvider.notifier).state = currentPath;
              Navigator.pushNamed(context, '/details');
            }
          },
        ),
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
                              style: const TextStyle(fontSize: 20)),
                          Text('$childLocationsCount unt |',
                              style: const TextStyle(fontSize: 20)),
                          Text('$totalUnitsInLocation itm |',
                              style: const TextStyle(fontSize: 20))
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
                            ref.read(pathProvider.notifier).state =
                                currentLoc.path,
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
