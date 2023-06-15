import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'add_update_task.dart';
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

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "Make Todo",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30,
            ),
          ),
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
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text(
                        "No Tesks Found",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index){
                        int todoId = snapshot.data![index].id!.toInt();
                        String todoTitle = snapshot.data![index].title.toString();
                        String todoDescription = snapshot.data![index].description.toString();
                        String todoDNT = snapshot.data![index].dateandtime.toString();
                        return Dismissible(
                          key: ValueKey<int>(todoId),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete_forever, color: Colors.white,),
                          ),
                          onDismissed: (DismissDirection direction){
                            setState(() {
                              dbHelper!.delete(todoId);
                              dataList = dbHelper!.getDataList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.yellowAccent.shade400,
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),]
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(10),
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      todoTitle,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                                  subtitle: Text(
                                    todoDescription,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 0.8,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        todoDNT,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => AddUpdateTask(
                                                todoId: todoId,
                                                todoTitle: todoTitle,
                                                todoDescription: todoDescription,
                                                todoDNT: todoDNT,
                                                updates: true,
                                              ),
                                              ));
                                        },
                                        child: Icon(
                                          Icons.edit_note,
                                          size: 28,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddUpdateTask()));
        },
      ),
    );
  }
}
