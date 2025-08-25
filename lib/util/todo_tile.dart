import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskTitle;
  final String taskContent;
  final DateTime taskDateTime;
  final bool taskCompleted;
  final bool isPinned;
  final VoidCallback deleteFunction;
  final VoidCallback editFunction;
  final VoidCallback onPin;
  final ValueChanged<bool?> onChanged;

  const ToDoTile({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.taskDateTime,
    required this.taskCompleted,
    required this.isPinned,
    required this.deleteFunction,
    required this.editFunction,
    required this.onPin,
    required this.onChanged,
  });

  void _showExpandedCard(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false, // keep background visible
      barrierColor: Colors.black54, // dimmed background
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 1.0,
              curve: Curves.easeOutBack,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          taskTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              taskContent,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: deleteFunction,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: editFunction,
                            ),
                            IconButton(
                              icon: Icon(
                                isPinned
                                    ? Icons.push_pin
                                    : Icons.push_pin_outlined,
                                color: Colors.white,
                              ),
                              onPressed: onPin,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showExpandedCard(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            taskTitle,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
