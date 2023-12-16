// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_coffee_firebase_app/models/brew.dart';
// import 'package:provider/provider.dart';
// class DatabaseServices{
//   final String uid;
//   DatabaseServices(this.uid);


//   final CollectionReference dataCollection = FirebaseFirestore.instance.collection('users_data');
//   final CollectionReference users = FirebaseFirestore.instance.collection('users');
//   Future updateUserData(String sugars, String name, int strenght)async{
//     return await dataCollection.doc(uid).set({
//       'sugars': sugars,
//       'name': name,
//       'strength' : strenght,
//     });
//   }
//   // brew list from snapshot
//   List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
//     return snapshot.docs.map((doc){
//       print('_________________________********************************________________');
//       print(doc.data().values.toList()[1]);
//       return Brew(
//         doc.data().values.toList()[0] ?? '' ,
//         doc.data().values.toList()[1] ?? 0,
//         doc.data().values.toList()[2] ?? '0',
//       );
//     }).toList();
//     print(Brew);
//   }


//   //Cllection Reference1
//   Stream<List<Brew>> get users_data{
//     return dataCollection.snapshots().map(_brewListFromSnapshot);
//   }
//   }