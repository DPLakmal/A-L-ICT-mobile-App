import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'common.dart';

// ignore: camel_case_types
class ShortNote_Page extends StatelessWidget {
  const ShortNote_Page({Key? key}) : super(key: key);

  static const tiles = [
    GridTile(2, 2),
    GridTile(2, 1),
    GridTile(2, 2),
    GridTile(2, 1),
    GridTile(2, 2),
    GridTile(2, 1),
    GridTile(2, 1),
    GridTile(3, 1),
    GridTile(1, 3),
    GridTile(1, 2),
    GridTile(2, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "- Shortnotes -",
                textScaleFactor: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  ...tiles.mapIndexed((index, tile) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: tile.crossAxisCount,
                      mainAxisCellCount: tile.mainAxisCount,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ImageTile(
                          index: index,
                          width: tile.crossAxisCount * 100,
                          height: tile.mainAxisCount * 100,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
