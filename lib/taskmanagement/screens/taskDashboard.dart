import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_list/drag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/taskmanagement/FirebaseRepositoory/dataRepository.dart';
import 'package:flutter_poc/taskmanagement/Model/category.dart';
import 'package:flutter_poc/taskmanagement/Model/tasks.dart';
import 'package:flutter_poc/utils/constantData.dart';

class TaskHome extends StatefulWidget {
  @override
  _TaskHomeState createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  final DataRepository repository = DataRepository();
  // List<String> category = ["Gift Ideas", "Gift To Get"];

  // List<List<String>> tasks = [
  //   ["Gift Idea 1", "Gift Idea 2", "Gift Idea 3", "Gift Idea 4"],
  //   ["Gift To Get 1", "Gift To Get 2", "Gift To Get 3", "Gift To Get 4"],
  // ];
  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  getCategoryList() {
    setState(() {
      categoryList = List<Category>();
    });

    Stream<QuerySnapshot> categoryData;
    categoryData = repository.getStream();
    categoryData.listen((event) { 
      categoryList=List<Category>();
    });
    categoryData.forEach((QuerySnapshot element) {
      if (element == null) return;
      setState(() {
        element.documents.forEach((f) {
          Category cat = Category.fromJson(f.data);
          categoryList.add(cat);
          cat.reference = f.reference;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Management"),
      ),
      body: _buildBody(),
    );
  }

  TextEditingController _cardTextController = TextEditingController();
  TextEditingController _taskTextController = TextEditingController();

  _showAddCard() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Category",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Category Title"),
                    controller: _cardTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.blue[900],
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCard(_cardTextController.text.trim());
                    },
                    child: Text("Add Category",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCard(String text) {
    Category newCat = Category(text);
    categoryList.add(newCat);
    repository.addCategory(newCat);
    // categoryList = null;
    setState(() {
      _cardTextController.text = "";
    });
  }

  _showAddCardTask(int index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Category Task",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: " Task Title"),
                    controller: _taskTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.blue[900],
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCardTask(index, _taskTextController.text.trim());
                    },
                    child: Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCardTask(int index, String text) {
    Tasks newTask = Tasks(text, index);
    if (categoryList[index].tasks != null) {
      categoryList[index].tasks.add(newTask);
    } else {
      List<Tasks> newList = List<Tasks>();
      categoryList[index].tasks = newList;
      categoryList[index].tasks.add(newTask);
    }
    repository.updateCategory(categoryList[index]);
    setState(() {
      _taskTextController.text = "";
    });
  }

  _buildBody() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length + 1,
      itemBuilder: (context, index) {
        if (index == categoryList.length)
          return _buildAddCardWidget(context);
        else
          return _buildCard(context, index);
      },
    );
  }

  Widget _buildAddCardWidget(context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _showAddCard();
          },
          child: Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Add Category",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Colors.blueAccent,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categoryList[index].name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showAddCardTask(index);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    categoryList[index].tasks == null
                        ? Container()
                        : SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: DragList<Tasks>(
                                items: categoryList[index].tasks,
                                itemExtent: 72,
                                onItemReorder: (from, to) {
                                  print("from $from");
                                  print("to $to");
                                  Tasks data = categoryList[index].tasks[from];
                                  categoryList[index].tasks[from] =
                                      categoryList[index].tasks[to];
                                  setState(() {
                                    repository
                                        .updateCategory(categoryList[index]);
                                    categoryList[index].tasks[to] = data;
                                    repository
                                        .updateCategory(categoryList[index]);
                                  });
                                  // handle item reorder on your own
                                },
                                handleBuilder: (_) => AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: AlwaysStoppedAnimation(0.0),
                                ),
                                feedbackHandleBuilder: (_, transition) =>
                                    AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: transition,
                                ),
                                itemBuilder: (_, item, handle) => Container(
                                  height: 72,
                                  child: Card(
                                    color: Colors.blue[100],
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCardTask(
                                              index,
                                              categoryList[index]
                                                  .tasks
                                                  .indexOf(item.value)),
                                          //  Center(child: Text(item.value)),
                                          handle,

                                          SizedBox(width: 10)
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                print(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                print("index $index");
                print("innerIndex" + data['innerIndex'].toString());
                print(data['from']);
                if (data['from'] == index) {
                  return;
                }
                  categoryList[data['from']].tasks.remove(data['task']);
                  repository.updateCategory(categoryList[data['from']]);
                  categoryList[index].tasks.add(data['task']);
                  repository.updateCategory(categoryList[index]);
                  print(data);
              },
              builder: (context, accept, reject) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTask(int index, int innerIndex) {
    return Row(
      children: [
        Container(
          
          width: 230.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Draggable<dynamic>(
            feedback: Material(
              elevation: 5.0,
              child: Container(
                color: Colors.blue[300],
                width: 280.0,
                padding: const EdgeInsets.all(16.0),
                // color: Colors.greenAccent,
                child: Text(categoryList[index].tasks[innerIndex].name),
              ),
            ),
            child: Container(
              
              padding: const EdgeInsets.all(16.0),
              child: Text(
                categoryList[index].tasks[innerIndex].name,
                style: TextStyle(
                    // color: Colors.white,
                    ),
              ),
            ),
            data: {
              "from": index,
              "task": categoryList[index].tasks[innerIndex],
              "innerIndex": innerIndex
            },
          ),
        ),
      ],
    );
  }
}
