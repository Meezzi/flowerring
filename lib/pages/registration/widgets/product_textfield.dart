import 'package:flutter/material.dart';

class ProductTextfield extends StatefulWidget {
  ProductTextfield(this.label, this.hintText, {super.key});
  final String label;
  final String hintText;
  @override
  State<StatefulWidget> createState() {
    return _ProductTextField();
  }
}

class _ProductTextField extends State<ProductTextfield> {
  final TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myController.addListener(() {
      print(myController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(color: Colors.black)),
        SizedBox(height: 4),
        TextField(
          controller: myController,
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
