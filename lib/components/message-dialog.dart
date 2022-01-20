import 'package:flutter/material.dart';
import 'package:my_little_poney/components/confirm_deletion_button.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    return SimpleDialog(
      title: Center(child: Text(title)),
      children: const [SizedBox(height: 0)],
    );
  }
}
