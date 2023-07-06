import 'package:dashboard/categories/web_services/get_tags.dart';
import 'package:flutter/material.dart';

class AddTag extends StatefulWidget {
  AddTag({super.key, required this.myTags, required this.seState});
  List myTags;
  VoidCallback seState;

  @override
  State<AddTag> createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  GetTags getTags = GetTags();
  addTag({tag}) async {
    widget.myTags.add(tag);
    await getTags.updateTag(newTags: widget.myTags);
    Navigator.pop(context);
    widget.seState();
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Category'),
        content: TextField(
            controller: _controller,
            decoration: const InputDecoration(label: Text('New Category'))),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900),
              onPressed: () {
                addTag(tag: _controller.text.trim());
              },
              child: const SizedBox(
                width: 70,
                height: 30,
                child: Center(
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )),
        ]);
  }
}
