
import 'package:flutter/material.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

//Mobile Screen for both android and ios app
class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key, required this.title});

  final String title;

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final watch = WatchConnectivity();
  final log = <String>[];
  TextEditingController textEditingController = TextEditingController();
  var receiveContext = <Map<String, dynamic>>[];

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
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  label: Text("Enter your data"), border: OutlineInputBorder()),
            ),
          ),
          TextButton(
              onPressed: () => sendMessage(textEditingController.text),
              child: Text("Send message")),
          SizedBox(
            height: 12,
          ),
          TextButton(onPressed: () => refresh(), child: Text("Refresh")),
          SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                itemCount: log.length,
                itemBuilder: (context, index) => Text(log[index]),
              ))
        ],
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

  Future<void> refresh() async {
    receiveContext = await watch.receivedApplicationContexts;
  }
}