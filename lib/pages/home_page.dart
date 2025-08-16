import 'package:assignments/widgets/my_chart.dart';
import 'package:assignments/widgets/tiles_layout.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  int _selectedIndex = 0;

  // New task fields
  String _newTitle = '';
  String _newContent = '';
  DateTime? _newDateTime;

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][3] = value ?? false;
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _newTitle,
        _newContent,
        _newDateTime ?? DateTime.now(),
        false,
      ]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          onChangedTitle: (value) => _newTitle = value,
          onChangedContent: (value) => _newContent = value,
          onDateTimePicked: (dateTime) => _newDateTime = dateTime,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  Widget buildTasksLayout() {
    return TilesLayout(
      db: db,
      onChanged: checkBoxChanged,
      onDelete: deleteTask,
    );
  }

  Widget buildChartLayout() {
    return MyChart(db: db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightGreen,
                    darkGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 35.0),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: textColor,
                        letterSpacing: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "You have completed ${db.toDoList.where((task) => task.length > 3 && task[3] == true).length} "
                      "out of ${db.toDoList.length} tasks",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetTween = Tween<Offset>(
                  begin: _selectedIndex == 0
                      ? const Offset(-1.0, 0.0)
                      : const Offset(1.0, 0.0),
                  end: Offset.zero,
                );
                return SlideTransition(
                  position: animation.drive(offsetTween),
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(_selectedIndex),
                color: backgroundColor, // Ensures background remains black
                //padding: const EdgeInsets.only(top: 0),
                child: _selectedIndex == 0
                    ? buildTasksLayout()
                    : buildChartLayout(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.only(left: 40, right: 40),
          height: 75,
          shape: const CircularNotchedRectangle(),
          color: navbarColor,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color: navbarIconColor
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.bar_chart,
                  size: 35,
                  color: navbarIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}