import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class AndroidWearScreen extends StatefulWidget {
  const AndroidWearScreen({super.key});

  @override
  State<AndroidWearScreen> createState() => _AndroidWearScreenState();
}

class _AndroidWearScreenState extends State<AndroidWearScreen> {
  final watch = WatchConnectivity();
  final log = <String>[];
  var receiveContext = <Map<String, dynamic>>[];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    watch.messageStream.listen((event) {
      setState(() {
        log.add("-> $event");
      });
       // sendMessage("Send back watch");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 24,
                    child: TextField(
                      controller: textEditingController,
                      style: TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                          label: Text("Enter your data", style: TextStyle(fontSize: 12),),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => sendMessage("${textEditingController.text}"),
                  icon: const Icon(Icons.send, size: 18,),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Text(log[index]),
                itemCount: log.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) {
    final message = {'dataMessage': text};
    watch.sendMessage(message);
    setState(() {
      log.add("<- $text");
    });
  }
}
