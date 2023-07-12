import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/users/components/ban_alert.dart';
import 'package:dashboard/users/webservices/get_users.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  final String userUid;
  final String userName;
  final String image;
  final String email;
  final bool isAdmin;
  final int reports;
  final void Function() onBanPressed;
  final VoidCallback onDeletePressed;
  const UserTile(
      {super.key,
      required this.onBanPressed,
      required this.userUid,
      required this.userName,
      required this.image,
      required this.email,
      required this.isAdmin,
      required this.onDeletePressed,
      required this.reports});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  GetUsers getUsers = GetUsers();
  bool? isBanned;
  isUserBanned() async {
    isBanned = await getUsers.isBanned(uid: widget.userUid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserBanned();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.image,
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
              widget.userName,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          Expanded(
              flex: 2,
              child: Tooltip(
                message: 'Email',
                child: Text(
                  widget.email,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
                ),
              )),
          Expanded(
              child: Tooltip(
            message: 'Role',
            child: Text(
              widget.isAdmin ? 'Admin' : 'User',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          Expanded(
              child: Tooltip(
            message: 'Number of reports',
            child: Text(
              widget.reports.toString(),
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
          )),
          IconButton(
              onPressed: () {
                if (!isBanned!) {
                  showDialog(
                      context: context,
                      builder: (context) => BanAlert(
                            uid: widget.userUid,
                            onBanPressed: widget.onBanPressed,
                          ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: const Text('User is already banned.'),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )),
                            ],
                          ));
                }
              },
              icon: const Icon(
                Icons.block,
                color: Colors.red,
              )),
          IconButton(
              onPressed: widget.onDeletePressed,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
