import 'package:flutter/material.dart';

class ProductTextfield extends StatefulWidget {
  ProductTextfield(this.label, this.hintText);
  final String label;
  final String hintText;
  @override
  State<StatefulWidget> createState() {
    return _ProductTextField();
  }
}

class _ProductTextField extends State<ProductTextfield> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(color: Colors.black)),
        SizedBox(height: 4),
        TextField(
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
