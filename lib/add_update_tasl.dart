import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'list.dart';

class AddUpdateTask extends StatefulWidget {
  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;
  late Future<List<TodoList>> dataList;

  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
      title: Text(
        "ADD / UPDATE",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      centerTitle: true,
      elevation: 0,
    ),
            body: Padding(
              padding: EdgeInsets.only(top: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Note Title",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter some text";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: descriptionController,
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Note Description",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Write note hear";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
    ),
    
    );
  }
}
