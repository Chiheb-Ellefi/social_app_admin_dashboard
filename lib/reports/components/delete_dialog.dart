import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.delete});
  final VoidCallback? delete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure you want to do this?',
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
      content: Text('This action can not be undone.',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade900)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              width: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  delete!();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
