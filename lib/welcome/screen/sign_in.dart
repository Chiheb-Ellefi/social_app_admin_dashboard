import 'package:dashboard/home_page/web_services/get_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';

  String password = '';
  bool notShowPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GetAdmin getAdmin = GetAdmin();

  final _formKey = GlobalKey<FormState>();

  Future<User?> signIn({email, password}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    bool isAdmin = await getAdmin.isAdmin(email.trim());
    if (isAdmin) {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        navigatorKey.currentState!.popUntil((route) => route.isFirst);

        return result.user;
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign In Error'),
              content: Text(e.message.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Sorry , but you are not an admin .'),
              ));
    }
  }

  Future onPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      dynamic result = await signIn(email: email, password: password);
      if (result == null) {
        print('error signing in');
      }
      print('signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  Text(
                    'Welcome back, boss!',
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: 500,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 56,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              onSaved: (value) {
                                email = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Invalid email format';
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 56, // Set the desired height
                            child: TextFormField(
                              obscureText: notShowPassword,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      notShowPassword = !notShowPassword;
                                    });
                                  },
                                  icon: notShowPassword
                                      ? const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                        ),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              onSaved: (value) {
                                password = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is required';
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade900,
                              minimumSize: const Size(200, 50),
                            ),
                            onPressed: onPressed,
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
