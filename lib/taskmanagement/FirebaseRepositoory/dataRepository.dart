import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_poc/taskmanagement/Model/category.dart';

class DataRepository {
  final CollectionReference collection =
      Firestore.instance.collection('category');

  Stream<QuerySnapshot> getStream() {
    collection.snapshots().listen((event) { 
      print("Listening");
      
    });
    return collection.snapshots();
  }

  Future<DocumentReference> addCategory (Category category) async{
    return  collection.add(category.toJson());
  }

  updateCategory(Category category) async {
      collection
        .document(category.reference.documentID)
        .updateData(category.toJson());
  }
}
