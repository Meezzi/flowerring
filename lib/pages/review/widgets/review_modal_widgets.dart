import 'package:flutter/material.dart';

///닫기 버튼 (상단 우측정렬)
Widget buildCloseButton(VoidCallback onClose){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        onPressed: onClose, 
        icon: const Icon(Icons.close)
      )
    ],
  );
}


