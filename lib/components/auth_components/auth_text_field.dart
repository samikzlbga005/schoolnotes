import 'package:flutter/material.dart';
import 'package:schoolnotes/components/form_container_widget.dart';

Widget CustomTextFiled(String text, TextEditingController _controller, bool val) {
  return FormContainerWidget(
    controller: _controller,
    hintText: text,
    isPasswordField: val,
  );
}
