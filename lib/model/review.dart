import 'package:intl/intl.dart';

class Review {
  final String username;
  final String profileImageUrl;
  final double rating;
  final String content;
  final String formattedDate;

  Review({
    required this.username,
    required this.profileImageUrl,
    required this.rating,
    required this.content,
    required this.formattedDate,
  });
}
