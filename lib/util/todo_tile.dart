import 'package:assignments/constants/colors.dart';
import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskTitle;
  final String taskContent;
  final DateTime taskDateTime;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final VoidCallback deleteFunction;
  final VoidCallback editFunction;

  const ToDoTile(
      {super.key,
      required this.taskTitle,
      required this.taskContent,
      required this.taskDateTime,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      required this.editFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Card(
        shadowColor: shadowColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color.fromARGB(255, 108, 107, 107)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            width: 230,
            decoration: BoxDecoration(
              color: tileBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: tileBorderColor,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ...existing code...
                Container(
                  height: 65,
                  padding: const EdgeInsets.all(5),
                  color: tileHeaderColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            fontSize: 22,
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    maxLines: 5,
                    taskContent.isNotEmpty
                        ? taskContent[0].toUpperCase() + taskContent.substring(1)
                        : 'No content to show',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: taskCompleted ? lightGreen : textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
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
      ),
    );
  }
}
