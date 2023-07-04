import 'package:dashboard/users/webservices/add_admin.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final _formKey = GlobalKey<FormState>();
  late String username, email, password, confirmPassword;
  late DateTime dateTime = DateTime.now();
  final TextEditingController controller = TextEditingController();
  bool notShowConfirmPassword = true;
  bool notShowPassword = true;
  PhoneNumber? number;
  AddAdminService admin = AddAdminService();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (password.trim() == confirmPassword.trim()) {
        // Passwords match, continue with form submission
        await admin.registerWithEmailAndPassword(
          mail: email,
          password: password,
          context: context,
          username: username,
          dob: dateTime,
          phoneNumber: number.toString(),
        );
      }
    }
  }

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != dateTime) {
      setState(() {
        dateTime = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('Add new admin'),
        content: SizedBox(
          width: 600,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid username';
                    }
                  },
                  onSaved: (value) {
                    username = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.length > 250) {
                      return 'Email is too long';
                    } else if (!(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value))) {
                      return 'Invalid email';
                    }
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
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
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid password';
                      } else if (value.length < 6) {
                        return '¨Password is too short ';
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 56,
                  child: TextFormField(
                    obscureText: notShowConfirmPassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            notShowConfirmPassword = !notShowConfirmPassword;
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
                      labelText: 'Confirm password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid password';
                      } else if (value != password) {
                        return 'password do not match ';
                      }
                    },
                    onSaved: (value) {
                      confirmPassword = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Birthday : ',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade800),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Phone number : ',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade800),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: IntlPhoneField(
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'TN',
                          onChanged: (newValue) {
                            number = newValue;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.blue.shade700,
            ),
            onPressed: submitForm,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text('Submit', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
