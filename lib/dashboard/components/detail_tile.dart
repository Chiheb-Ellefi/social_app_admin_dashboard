import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  const DetailTile(
      {super.key,
      required this.icon,
      required this.number,
      required this.text});
  final String text;
  final IconData icon;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey.shade100.withOpacity(0.5),
            ),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.grey.shade200,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '$number',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
