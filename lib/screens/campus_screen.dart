import 'package:flutter/material.dart';

import '../category_data.dart';
import '../widgets/main_drawer.dart';
import '../widgets/campus_item.dart';

class CampusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: MainDrawer(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: CAMPUS_CATEGORIES
                .map((campus) => CampusItem(campus.name, campus.image))
                .toList(),
          ),
        ],
      ),
    );
  }
}
