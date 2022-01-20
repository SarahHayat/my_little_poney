import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildListView(data, Function _buildRow) {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        return _buildRow(data[index]);
      });
}
