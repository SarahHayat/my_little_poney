import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/datetime_extension.dart';
import 'package:my_little_poney/models/Lesson.dart';

class ListViewSeparated extends StatelessWidget {
  /// Creates a ListView with each elements separated by Divider().
  /// [data] is a List of Object.
  /// [buildRow] is a Function using one o this object to render a Widget.
  /// [axis] is the listView axis (vertical by default)
  const ListViewSeparated({Key? key, required this.data, required this.buildRow, this.axis:Axis.vertical}) : super(key: key);
  final dynamic data;
  final Function buildRow;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: data.length * 2,
        scrollDirection: axis,
        controller: ScrollController(),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          return buildRow(data[index]);
        });
  }
}
