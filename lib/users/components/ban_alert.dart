import 'package:dashboard/users/webservices/get_users.dart';
import 'package:flutter/material.dart';

class BanAlert extends StatefulWidget {
  const BanAlert({
    super.key,
    required this.uid,
    required this.onBanPressed,
  });
  final String uid;
  final void Function() onBanPressed;

  @override
  State<BanAlert> createState() => _BanAlertState();
}

class _BanAlertState extends State<BanAlert> {
  GetUsers getUsers = GetUsers();
  late DateTime dateTime = DateTime.now();
  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != dateTime) {
      setState(() {
        dateTime = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ban User'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Enter the date for when user is banned '),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${dateTime.day.toString()} / ${dateTime.month.toString()} / ${dateTime.year.toString()}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
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
                  getUsers.banUser(uid: widget.uid, duration: dateTime);
                  Navigator.pop(context);
                  widget.onBanPressed();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Ban',
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
