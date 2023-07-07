import 'package:flutter/material.dart';

class ReportTile extends StatelessWidget {
  ReportTile(
      {super.key,
      required this.title,
      required this.author,
      required this.delete,
      required this.read});
  final title;
  final author;
  VoidCallback delete;
  VoidCallback read;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: TextStyle(fontSize: 20, color: Colors.grey.shade200),
        )),
        Expanded(
            child: Text(
          author,
          style: TextStyle(fontSize: 20, color: Colors.grey.shade200),
        )),
        IconButton(
            onPressed: read,
            icon:
                const Icon(Icons.remove_red_eye, size: 30, color: Colors.grey)),
        IconButton(
            onPressed: delete,
            icon: const Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            )),
      ],
    );
  }
}
