import '../widgets/expandable_task_card.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

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
  final int index;

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
    required this.index,
  });

  void _showFullScreenCard(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Hero(
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
      onTap: () => _showFullScreenCard(context),
      child: Hero(
        tag: 'task_$index',
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
    );
  }
}