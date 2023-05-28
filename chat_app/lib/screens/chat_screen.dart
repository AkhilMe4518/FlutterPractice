import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void pushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    // final token = await fcm.getToken();
    // print(token);

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    pushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app_rounded),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}

class FireBaseMessaging {}
