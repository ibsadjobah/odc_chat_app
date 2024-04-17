import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key, required this.message});

  late Map message;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Map msg;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    msg = widget.message;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sent by'),
        backgroundColor: Color.fromARGB(214, 3, 56, 109),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ), 
          child: Text(
            widget.message['user']['nom'],
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
