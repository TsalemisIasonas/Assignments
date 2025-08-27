import 'package:assignments/constants/colors.dart';
import 'package:flutter/material.dart';

class ExpandableTaskCard extends StatelessWidget {
  final String taskTitle;
  final String taskContent;
  final DateTime taskDateTime;
  final bool taskCompleted;
  final bool isPinned;
  final Color tileBackgroundColor;
  final Color tileHeaderColor;
  final Color tileBorderColor;
  final Color textColor;
  final VoidCallback onPin;
  final VoidCallback deleteFunction;
  final VoidCallback editFunction;
  final Function(bool?)? onChanged;

  const ExpandableTaskCard({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.taskDateTime,
    required this.taskCompleted,
    required this.isPinned,
    required this.tileBackgroundColor,
    required this.tileHeaderColor,
    required this.tileBorderColor,
    required this.textColor,
    required this.onPin,
    required this.deleteFunction,
    required this.editFunction,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black54,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: tileBorderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: tileBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tileBorderColor),
          ),
          child: Stack(
            children: [
              // Scrollable content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 105, 16, 70),
                child: SingleChildScrollView(
                  child: Center(
                    child: Text(
                      taskContent.isNotEmpty
                          ? taskContent[0].toUpperCase() + taskContent.substring(1)
                          : 'No content to show',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: taskCompleted ? lightGreen : textColor,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              // Header
              Container(
                height: 65,
                padding: const EdgeInsets.all(5),
                color: tileHeaderColor,
                child: Row(
                  children: [
                    Checkbox(
                      value: taskCompleted,
                      onChanged: onChanged,
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        taskTitle[0].toUpperCase() + taskTitle.substring(1),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          decoration:
                              taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                          color: Colors.white),
                      onPressed: onPin,
                    ),
                  ],
                ),
              ),

              // Bottom buttons and due date
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Due Date: "
                        "${taskDateTime.day.toString().padLeft(2, '0')}/"
                        "${taskDateTime.month.toString().padLeft(2, '0')}/"
                        "${taskDateTime.year}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: deleteFunction,
                            icon: const Icon(Icons.delete, color: Colors.white, size: 25),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: editFunction,
                            icon: const Icon(Icons.edit, color: Colors.white, size: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
