import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageContoller = TextEditingController();

  @override
  void dispose() {
    _messageContoller.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enterdMessage = _messageContoller.text;
    if (enterdMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageContoller.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enterdMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageContoller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: 'Send a message...'),
          )),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
