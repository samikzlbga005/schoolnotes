import 'package:flutter/material.dart';

Widget CustomDropDownButton(Function(String) callback, String val) {
  return Container(
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: Colors.grey[300]!.withOpacity(1),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0),
    child: DropdownButton<String>(
      isExpanded: true,
      underline: SizedBox(),
      value: val,
      onChanged: (String? newValue) {
        print(newValue);
        callback(newValue!);
      },
      items: <String>['9. Sınıf', '10. Sınıf', '11. Sınıf', '12. Sınıf']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
