import 'package:flutter/material.dart';
import 'package:todo1_app/modules/archived_tasks/archived_tasks.dart';
import 'package:todo1_app/modules/done_tasks/done_tasks.dart';
import 'package:todo1_app/modules/new_tasks/new_Tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo1_app/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> listOfPages = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(titles[currentIndex]),
        ),
        body: listOfPages[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // insertToDatabase();
            if (isBottomSheetShown) {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            } else {
              scaffoldKey.currentState?.showBottomSheet(
                (context) => Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                        controller: titleControler,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'title must not be empty';
                          }
                          return null;
                        },
                        label: 'Task Title',
                        onChange: () {},
                        onSubmit: () {},
                        prefix: Icons.text_fields,
                      ),
                    ],
                  ),
                ),
              );
              isBottomSheetShown = true;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          },
          child: Icon(fabIcon),
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

  Future<String> getName() async {
    return 'Happy';
  }

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) => print('table created'))
          .catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    }, onOpen: (databse) {
      print('databse opened');
    });
  }

  void insertToDatabase() async {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("testTitle", "testDate", "testTime", "testStatus")')
          .then((value) {
        print('table inserted succes');
      }).catchError((error) {
        print('Error when inserting ${error.toString()}');
      });
    });
    return null;
  }
}
