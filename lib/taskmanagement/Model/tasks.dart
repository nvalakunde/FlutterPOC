
import 'package:cloud_firestore/cloud_firestore.dart';


class Tasks {
  String name;
  int index;
  DocumentReference reference;

  Tasks(this.name, this.index,{this.reference});

  factory Tasks.fromJson(Map<dynamic, dynamic> json) => _tasksFromJson(json);

  Map<String, dynamic> toJson() => _tasksToJson(this);

  @override
  String toString() => "$name";

}

Tasks _tasksFromJson(Map<dynamic, dynamic> json) {
  return Tasks(
    json['name'] as String,
    json['index'] as int,
  );
}

Map<String, dynamic> _tasksToJson(Tasks instance) =>
    <String, dynamic> {
      'name': instance.name,
      'index': instance.index,
    };

// class Tasks {
//        static const NAME_KEY = 'name';
//        static const INDEX_KEY = 'index';
//        String name;
//        int index;

//        Tasks(Map<String, dynamic> json) {
//            name = json[NAME_KEY];
//            index = json[INDEX_KEY];
//        }
// }