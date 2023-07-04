import 'package:dashboard/categories/web_services/get_tags.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditTag extends StatefulWidget {
  EditTag(
      {super.key,
      required this.myTags,
      required this.index,
      required this.setState});
  List<dynamic>? myTags;
  int index;
  VoidCallback setState;
  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  final _controller = TextEditingController();

  GetTags getTags = GetTags();
  edit({index}) async {
    setState(() {
      widget.myTags![index] = _controller.text;
    });
    await getTags.updateTag(newTags: widget.myTags);
    Navigator.pop(context);
    widget.setState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(label: Text('Edit tag')),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade400),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const SizedBox(
              width: 70,
              height: 30,
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
            onPressed: () {
              edit(index: widget.index);
            },
            child: const SizedBox(
              width: 70,
              height: 30,
              child: Center(
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
      ],
    );
  }
}
