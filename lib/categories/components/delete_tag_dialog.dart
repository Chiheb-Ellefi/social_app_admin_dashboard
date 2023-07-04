import 'package:dashboard/categories/web_services/get_tags.dart';
import 'package:flutter/material.dart';

class DeleteTagDialog extends StatefulWidget {
  DeleteTagDialog(
      {super.key,
      required this.myTags,
      required this.index,
      required this.setState});
  List<dynamic>? myTags;
  int index;
  VoidCallback setState;
  @override
  State<DeleteTagDialog> createState() => _DeleteTagDialogState();
}

class _DeleteTagDialogState extends State<DeleteTagDialog> {
  GetTags getTags = GetTags();
  delete({index}) async {
    setState(() {
      widget.myTags!.removeAt(index);
    });
    await getTags.updateTag(newTags: widget.myTags);
    Navigator.pop(context);
    widget.setState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure you want to delete?',
        style: TextStyle(fontSize: 25, color: Colors.red),
      ),
      content: Text(
        'This action can not be undone.',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade900),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              delete(index: widget.index);
            },
            child: const SizedBox(
              width: 70,
              height: 30,
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
      ],
    );
  }
}
