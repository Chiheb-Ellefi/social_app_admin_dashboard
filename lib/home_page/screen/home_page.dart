import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/categories/screen/categories_screen.dart';
import 'package:dashboard/dashboard/screen/dashboard.dart';
import 'package:dashboard/data/models/user_model.dart';
import 'package:dashboard/home_page/web_services/get_admin.dart';
import 'package:dashboard/terms_of_use/screen/terms_of_use_screen.dart';
import 'package:dashboard/users/screen/users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> _pages = [
    'Dashboard',
    'Users',
    'Categories/Tags',
    'Reports',
    'Terms of use'
  ];

  String userPhotoUrl = '';

  GetAdmin admin = GetAdmin();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  UserModel? adminData;

  Future<void> getAdminData() async {
    adminData = await admin.getAdminProfile(uid: uid);
    if (mounted) {
      setState(() {
        userPhotoUrl = adminData?.profilePicture ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CachedNetworkImage(
                    imageUrl: '$userPhotoUrl',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 40,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Admin',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _pages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedIndex == index
                                  ? Colors.grey.shade100.withOpacity(0.1)
                                  : Colors.grey.shade900,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _pages[index],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey.shade100.withOpacity(0.5),
            width: 2.0,
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                switch (_selectedIndex) {
                  case 0:
                    return const DashboardScreen();
                  case 1:
                    return const UsersScreen();
                  case 2:
                    return const CategoriesScreen();
                  case 4:
                    return const TermsOfUse();
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
