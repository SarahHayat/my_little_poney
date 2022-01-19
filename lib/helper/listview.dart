import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget buildListView(data, Function _buildRow, {axis:Axis.vertical}) {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data.length * 2,
      scrollDirection: axis,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        return _buildRow(data[index]);
      });
}