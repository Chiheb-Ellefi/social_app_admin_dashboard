import 'package:dashboard/components/popup_menu_button.dart';
import 'package:dashboard/terms_of_use/web_sevices/get_terms.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  GetTermsOfUse getTermsOfUse = GetTermsOfUse();
  String? terms;
  bool onEdit = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTerms();
  }

  Future<void> getTerms() async {
    terms = await getTermsOfUse.getTerms();
    textEditingController.text = terms ?? '';
    setState(() {}); // Update the state after fetching the terms
  }

  Future<void> updateTerms({myTerms}) async {
    setState(() {
      terms = myTerms;
    });
    await getTermsOfUse.updateTerms(terms: terms);
  }

  void toggleEdit() {
    setState(() {
      onEdit = !onEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Terms of use',
          style: TextStyle(fontSize: 25, color: Colors.grey.shade100),
        ),
        actions: const [
          MyPopUpMenuButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!onEdit)
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade700),
                    onPressed: toggleEdit,
                    child: const SizedBox(
                      width: 80,
                      height: 20,
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: (MediaQuery.of(context).size.width / 10) * 8,
                padding: const EdgeInsets.all(15),
                decoration: onEdit
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.shade100.withOpacity(0.5),
                        ),
                      )
                    : const BoxDecoration(),
                child: onEdit
                    ? TextField(
                        controller: textEditingController,
                        style: TextStyle(
                            color: Colors.grey.shade200, fontSize: 18),
                        maxLines: 15,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter the terms...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      )
                    : Text(
                        terms ??
                            'Loading...', // Display "Loading..." while fetching the terms
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.justify,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (onEdit)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade100),
                        onPressed: () {
                          setState(() {
                            onEdit = !onEdit;
                            textEditingController.text = terms!;
                          });
                        },
                        child: const SizedBox(
                            width: 80,
                            height: 20,
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 18),
                            )))),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade700),
                        onPressed: () {
                          updateTerms(
                              myTerms: textEditingController.text.trim());
                          setState(() {
                            onEdit = !onEdit;
                          });
                        },
                        child: const SizedBox(
                            width: 80,
                            height: 20,
                            child: Center(
                                child: Text(
                              'Save',
                              style: TextStyle(fontSize: 18),
                            )))),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
