// model/review.dart
import 'package:intl/intl.dart';

class Review {
  final String username;
  final String profileImageUrl;
  final double rating;
  final String content;

  Review({
    required this.username,
    required this.profileImageUrl,
    required this.rating,
    required this.content, required String formattedDate,
  });

  // 날짜를 "X일 전" 또는 "X주 전" 형식으로 포맷팅
  
}