import 'package:assignments/data/database.dart';
import 'package:flutter/material.dart';

class UsernameDialogBox extends StatelessWidget {
  final ToDoDataBase db;
  final TextEditingController userNameController;

  const UsernameDialogBox(
      {super.key, required this.db, required this.userNameController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(
              hintText: "Enter your Name",
            ),
          ),
          TextButton(
            child: const Text("Save"),
            onPressed: () {
              db.userName = userNameController.text;
              db.storeName();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
