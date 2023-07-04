import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final String image;
  final String email;
  final bool isAdmin;
  final int reports;
  final VoidCallback onDeletePressed;
  const UserTile(
      {super.key,
      required this.userName,
      required this.image,
      required this.email,
      required this.isAdmin,
      required this.onDeletePressed,
      required this.reports});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 20,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Tooltip(
            message: 'Username',
            child: Text(
              userName,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          Expanded(
              flex: 2,
              child: Tooltip(
                message: 'Email',
                child: Text(
                  email,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
                ),
              )),
          Expanded(
              child: Tooltip(
            message: 'Role',
            child: Text(
              isAdmin ? 'Admin' : 'User',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          Expanded(
              child: Tooltip(
            message: 'Number of reports',
            child: Text(
              reports.toString(),
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.block,
                color: Colors.red,
              )),
          IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
