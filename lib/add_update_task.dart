import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dbHelper.dart';
import 'home_screen.dart';
import 'list.dart';

class AddUpdateTask extends StatefulWidget {
  int? todoId;
  String? todoTitle;
  String? todoDescription;
  String? todoDNT;
  bool? updates;

  AddUpdateTask(
      {this.todoId,
        this.todoTitle,
        this.todoDescription,
        this.todoDNT,
        this.updates});

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
    final titleController = TextEditingController(text: widget.todoTitle);
    final descriptionController = TextEditingController(text: widget.todoDescription);
    String appTitle;
    if (widget.updates == true) {
      appTitle = "Update Task";
    } else {
      appTitle = "Add task";
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(
          appTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          if (_fromKey.currentState!.validate()) {
                            if(widget.updates == true){
                              dbHelper!.update(TodoList(
                                id: widget.todoId,
                                title: titleController.text,
                                description: descriptionController.text,
                                dateandtime: widget.todoDNT,
                              ));
                            }else{
                              dbHelper!.insert(TodoList(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  dateandtime: DateFormat('yMd')
                                      .add_jm()
                                      .format(DateTime.now())
                                      .toString()));
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                            titleController.clear();
                            descriptionController.clear();
                            print("data added");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            titleController.clear();
                            descriptionController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          width: 120,
                          decoration: BoxDecoration(),
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
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

