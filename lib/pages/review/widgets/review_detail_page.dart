import 'package:flutter/material.dart';


//리뷰 탭 타이틀
class headerTitle extends StatelessWidget{
  const headerTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: Text(
        "후기",
        style: TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(34, 34, 34, 1)
        ),
      ),
    );
  }

}





//리뷰 탭 리뷰작성 버튼