import 'package:flutter/material.dart';
import 'add_update_tasl.dart';
import 'dbHelper.dart';
import 'list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<TodoList>> dataList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: dataList,
            builder: (context, AsyncSnapshot<List<TodoList>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    "No Task Fount",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }else {
                return Container();
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton (
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddUpdateTask()));
        },
      ),
    );
  }
}
