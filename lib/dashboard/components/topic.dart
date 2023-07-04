import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Topic extends StatelessWidget {
  Topic({
    Key? key,
    required this.date,
    required this.rating,
    required this.title,
    required this.username,
  }) : super(key: key);

  final String title;
  final String username;
  final DateTime date;
  final double rating;

  final TextStyle myStyle =
      TextStyle(color: Colors.grey.shade100, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: myStyle,
          ),
        ),
        Expanded(
          child: Text(
            username,
            style: myStyle,
          ),
        ),
        Expanded(
          child: Text(
            '${date.day}-${date.month}-${date.year}',
            style: myStyle,
          ),
        ),
        Expanded(
          child: RatingBar.builder(
            itemBuilder: (context, _) => const Icon(
              Icons.star_rate,
              color: Color.fromRGBO(255, 195, 0, 1),
            ),
            onRatingUpdate: (rating) {},
            allowHalfRating: true,
            initialRating: rating,
            ignoreGestures: true,
            itemSize: 20,
            unratedColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
