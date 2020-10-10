
import 'package:cloud_firestore/cloud_firestore.dart';

import 'tasks.dart';

class Category {
  String name;
  List<Tasks> tasks;
  DocumentReference reference;

  Category(this.name, {this.reference, this.tasks});

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    Category newCategory = Category.fromJson(snapshot.data);
    newCategory.reference = snapshot.reference;
    return newCategory;
  }

  factory Category.fromJson(Map<String, dynamic> json) => _categoryFromJson(json);

  Map<String, dynamic> toJson() => _categoryToJson(this);

  @override
  String toString() => "$name";
}

Category _categoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['name'] as String,
    tasks: _converttasks(json['TaskList'] as List)
  );
}

List<Tasks> _converttasks(List tasksMap) {
  if (tasksMap == null) {
    return null;
  }
  List<Tasks> tasks =  List<Tasks>();
  tasksMap.forEach((value) {
    tasks.add(Tasks.fromJson(value));
  });
  return tasks;
}

Map<String, dynamic> _categoryToJson(Category instance) => <String, dynamic> {
      'name': instance.name,
      'TaskList': _tasksList(instance.tasks),
    };

List<Map<String, dynamic>> _tasksList(List<Tasks> tasks) {
  if (tasks == null) {
    return null;
  }
  List<Map<String, dynamic>> tasksMap =List<Map<String, dynamic>>();
  tasks.forEach((task) {
    tasksMap.add(task.toJson());
  });
  return tasksMap;
}
