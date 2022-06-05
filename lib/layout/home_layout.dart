import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo1_app/modules/archived_tasks/archived_tasks.dart';
import 'package:todo1_app/modules/done_tasks/done_tasks.dart';
import 'package:todo1_app/modules/new_tasks/new_Tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> listOfPages = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titles[currentIndex]),
        ),
        body: listOfPages[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'Archived'),
            ]));
  }
}
