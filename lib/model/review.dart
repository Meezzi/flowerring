// model/review.dart
import 'package:intl/intl.dart';

class Review {
  final String username;
  final String profileImageUrl;
  final double rating;
  final DateTime date;
  final String content;

  Review({
    required this.username,
    required this.profileImageUrl,
    required this.rating,
    required this.date,
    required this.content,
  });

  // 날짜를 "X일 전" 또는 "X주 전" 형식으로 포맷팅
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      return "오늘";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}일 전";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()}주 전";
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }
}