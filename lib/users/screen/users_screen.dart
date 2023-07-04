import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/components/popup_menu_button.dart';
import 'package:dashboard/data/models/user_model.dart';
import 'package:dashboard/users/components/user_tile.dart';
import 'package:dashboard/users/screen/add_admin_screen.dart';
import 'package:dashboard/users/webservices/get_users.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  GetUsers getUsers = GetUsers();
  late Stream<QuerySnapshot<UserModel>> stream;

  @override
  void initState() {
    super.initState();
    stream = getUsers.getQuery().snapshots();
  }

  Future<int> getReports({uid}) async {
    int reports = await getUsers.getReports(uid: uid);

    return reports;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Users',
          style: TextStyle(fontSize: 25, color: Colors.grey.shade100),
        ),
        actions: const [
          MyPopUpMenuButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('Add admin'),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AddAdmin(),
                      // Display the AddAdmin widget
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot<UserModel>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final documents = snapshot.data?.docs ?? [];
                    return Center(
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 10) * 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade100.withOpacity(0.5),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final userModel = documents[index].data();
                            final username = userModel.username;
                            final email = userModel.email;
                            final image = userModel.profilePicture;
                            final isAdmin = userModel.isAdmin;

                            return FutureBuilder<int>(
                              future: getReports(uid: userModel.uid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final reports = snapshot.data ?? 0;

                                  return UserTile(
                                    userName: username!,
                                    image: image!,
                                    email: email!,
                                    isAdmin: isAdmin!,
                                    reports: reports,
                                    onDeletePressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'Are you sure you want to delete ? ',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.red),
                                                ),
                                                content: const Text(
                                                    'This operation cannot be undone .'),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
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
                                                            getUsers.deleteUser(
                                                                userModel.uid!);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red),
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ));
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
