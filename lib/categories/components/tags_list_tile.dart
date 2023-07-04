import 'package:flutter/material.dart';

class TagsListTile extends StatelessWidget {
  const TagsListTile(
      {super.key,
      required this.delete,
      required this.edit,
      required this.num,
      required this.text});
  final text;
  final num;
  final VoidCallback edit;
  final VoidCallback delete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: 'Tag',
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ),
          Tooltip(
            message: 'Topics',
            child: Text(
              num.toString(),
              style: TextStyle(
                  color: Colors.grey.shade100,
                  fontSize: 20,
                  fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(width: 250),
          Row(
            children: [
              Tooltip(
                  message: 'Edit',
                  child: IconButton(
                      onPressed: edit,
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.white,
                      ))),
              const SizedBox(
                width: 20,
              ),
              Tooltip(
                  message: 'Delete',
                  child: IconButton(
                      onPressed: delete,
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      )))
            ],
          )
        ],
      ),
    );
  }
}
