import 'package:flutter/material.dart';

class TopicAlert extends StatelessWidget {
  const TopicAlert(
      {super.key,
      this.title,
      this.author,
      this.description,
      this.reasons,
      this.delete});
  final title;
  final author;
  final description;
  final List? reasons;
  final VoidCallback? delete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.9,
          width: MediaQuery.sizeOf(context).width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.grey.shade900),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade800),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 200,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Author',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.grey.shade900),
                            ),
                            Text(
                              author,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade800),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: delete,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const SizedBox(
                        width: 80,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 20),
                        ))),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 30, color: Colors.grey.shade900),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Reasons',
                style: TextStyle(fontSize: 30, color: Colors.grey.shade900),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reasons?.length ?? 0,
                  itemBuilder: (context, index) {
                    final reason = reasons?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        reason ?? '',
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade800),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
