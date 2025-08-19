import 'package:assignments/data/database.dart';
import 'package:assignments/util/todo_tile.dart';
import 'package:flutter/material.dart';

class TilesLayout extends StatefulWidget {
  final ToDoDataBase db;
  final Function(bool?, int) onChanged;
  final Function(int) onDelete;
  final Function(int) onEdit;
  final Function(int, bool) onPin;

  const TilesLayout({
    super.key,
    required this.db,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
    required this.onPin,
  });

  @override
  State<TilesLayout> createState() => _TilesLayoutState();
}

class _TilesLayoutState extends State<TilesLayout> {
  bool _showSearch = false;
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Filter tasks based on search query
    final filteredList = _searchQuery.isEmpty
        ? widget.db.toDoList
        : widget.db.toDoList.where((task) {
            final title = task[0].toString().toLowerCase();
            final content = task[1].toString().toLowerCase();
            return title.contains(_searchQuery.toLowerCase()) ||
                content.contains(_searchQuery.toLowerCase());
          }).toList();

    // Sort: pinned tasks first
    filteredList.sort((a, b) {
      final aPinned = a.length > 4 && a[4] == true;
      final bPinned = b.length > 4 && b[4] == true;
      if (aPinned && !bPinned) return -1;
      if (!aPinned && bPinned) return 1;
      return 0;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppBar().titleSpacing ?? 16.0, vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: _showSearch
                    ? TextField(
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Search tasks...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      )
                    : Text(
                        widget.db.toDoList.isNotEmpty
                            ? "My Tasks"
                            : "No tasks yet. Add a new task",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
              IconButton(
                icon: Icon(
                  _showSearch ? Icons.close : Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (_showSearch) {
                      _searchQuery = '';
                    }
                    _showSearch = !_showSearch;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final originalIndex = widget.db.toDoList.indexOf(filteredList[index]);
              final isPinned = filteredList[index].length > 4 && filteredList[index][4] == true;
              return ToDoTile(
                taskTitle: filteredList[index][0],
                taskContent: filteredList[index][1],
                taskDateTime: filteredList[index][2],
                taskCompleted: filteredList[index][3],
                onChanged: (value) => widget.onChanged(value, originalIndex),
                deleteFunction: () => widget.onDelete(originalIndex),
                editFunction: () => widget.onEdit(originalIndex),
                isPinned: isPinned,
                onPin: () {
                  widget.onPin(originalIndex, !isPinned);
                  setState(() {});
                  // Scroll to start after pin/unpin
                  _scrollController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
