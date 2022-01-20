import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  ///
  /// Example of usage
  /// ```
  /// String dropdownValueRole = UserRole.rider.toShortString();
  ///   buildDropdownRole() {
  ///     return Dropdown(
  ///       title: 'Rôle : ',
  ///       value: dropdownValueRole,
  ///       onChanged: (String? newValue){
  ///         setState(() {
  ///           dropdownValueRole = newValue!;
  ///         });
  ///       },
  ///       item: UserRole.values.map<DropdownMenuItem<String>>((UserRole value) {
  ///         return DropdownMenuItem<String>(
  ///           value: value.name,
  ///           child: Text(value.name),
  ///         );
  ///       }).toList(),
  ///     );
  ///  }
  /// ```
  const Dropdown({Key? key, this.title, required this.value, required this.onChanged, required this.item}) : super(key: key);
  final String? title;
  final String value;
  final Function onChanged;
  final List<DropdownMenuItem<String>> item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title!),
        DropdownButton(
          value: value,
          icon: const Icon(Icons.arrow_downward, size: 17,),
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            onChanged(newValue);
          },
          items:item,
        ),
      ],
    );
  }
}
