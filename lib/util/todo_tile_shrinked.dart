import '../constants/colors.dart';
import '../widgets/expandable_task_card.dart';
import 'package:flutter/material.dart';

class ToDoTileShrinked extends StatelessWidget {
  final String taskTitle;
  final String taskContent; // New property for the full content
  final DateTime taskDateTime;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback deleteFunction;
  final VoidCallback editFunction;
  final bool isPinned;
  final VoidCallback onPin;
  final int index; // New property to create a unique Hero tag

  const ToDoTileShrinked({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.taskDateTime,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.isPinned,
    required this.onPin,
    required this.index, // Add this to the constructor
  });

  // This method navigates to a new page with a transparent background
  // and uses a Hero animation for a smooth transition.
  void _showFullScreenCard(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => GestureDetector(
          // Tapping the barrier will pop the screen
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Hero(
                // Use the same unique tag for the Hero animation
                tag: 'task_$index',
                child: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ExpandableTaskCard(
                      taskTitle: taskTitle,
                      taskContent: taskContent,
                      taskDateTime: taskDateTime,
                      taskCompleted: taskCompleted,
                      isPinned: isPinned,
                      deleteFunction: deleteFunction,
                      editFunction: editFunction,
                      onPin: onPin,
                      onChanged: onChanged,
                      tileBackgroundColor: tileBackgroundColor,
                      tileHeaderColor: tileHeaderColor,
                      tileBorderColor: tileBorderColor,
                      textColor: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // The onTap handler now calls the method to show the full screen card
      onTap: () => _showFullScreenCard(context),
      child: Hero(
        // Wrap the Card with a Hero widget to enable the animation
        tag: 'task_$index',
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: lightGreen),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: tileBorderColor,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Checkbox(value: taskCompleted, onChanged: onChanged),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2.0),
                      child: Text(
                        taskTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      color: Colors.white,
                      size: 17,
                    ),
                    onPressed: onPin,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
