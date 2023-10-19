import 'package:flutter/material.dart';

class ChatDetail extends StatefulWidget {
  final String? massage;

  const ChatDetail({Key? key, this.massage}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  TextEditingController massage = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    massage.text = widget.massage ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("name"),
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.70,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "hello my name is harsh balar i am a bca student and writ now i am study flutter.",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.account_circle),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "10:30",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.70,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "hello my name is harsh balar i am a bca student and writ now i am study flutter.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "10:30",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.account_circle),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.photo_album_rounded),
                  iconSize: 25,
                  color: Colors.blueGrey,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "send a message",
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded),
                  iconSize: 25,
                  color: Colors.blueGrey,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
