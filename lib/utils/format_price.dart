import 'package:intl/intl.dart';

// 숫자 3자리마다 ,를 추가
String formatPrice(int value) {
  final formatter = NumberFormat('#,###');
  return formatter.format(value);
}
