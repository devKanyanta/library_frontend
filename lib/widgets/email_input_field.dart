import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;

  const EmailInput({
    Key? key,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0), // Adjust padding as needed
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!, // Set the color of the border
          width: 1.0, // Set the width of the border
        ),
        borderRadius: BorderRadius.circular(8.0), // Set the border radius
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500]!,
            fontSize: 14
          ),
          border: InputBorder.none, // Hide the default border of TextFormField
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust content padding
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14
        ),
        onChanged: onChanged,
      ),
    );
  }
}
