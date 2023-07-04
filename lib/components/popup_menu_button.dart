import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPopUpMenuButton extends StatelessWidget {
  const MyPopUpMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 25,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_sharp,
                        color: Colors.black87,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )),
            ]);
  }
}
