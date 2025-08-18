import 'package:assignments/data/database.dart';
import 'package:assignments/util/todo_tile.dart';
import 'package:flutter/material.dart';

class TilesLayout extends StatelessWidget {
  final ToDoDataBase db;

  final Function(bool?, int) onChanged;
  final Function(int) onDelete;
  final Function(int) onEdit;

  const TilesLayout({
    super.key,
    required this.db,
    required this.onChanged, // Add to constructor
    required this.onDelete, // Add to constructor
    required this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20.0),
          child: Text(
            db.toDoList.isNotEmpty ? "My Tasks" : "No tasks yet. Add a new task",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskTitle: db.toDoList[index][0],
                taskContent: db.toDoList[index][1],
                taskDateTime: db.toDoList[index][2], //?? DateTime.now(),
                taskCompleted: db.toDoList[index][3],
                onChanged: (value) => onChanged(value, index),
                deleteFunction: () => onDelete(index),
                editFunction: () => onEdit(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
