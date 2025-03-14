import 'package:cloud_firestore/cloud_firestore.dart';



class StorageService {
  final firestore = FirebaseFirestore.instance;


 
  Future<void> write(String key, dynamic value) async {
    var doc = await firestore.collection(key).add(value);
    await doc.update({'docId':doc.id});
  }
  
 
  dynamic read(String key, String uid) async {
    var snapshot = await firestore.
        collection(key).
        where('uid', isEqualTo:uid).
        get();
      return snapshot.docs.map((doc)=> doc.data()).toList();
    
  }

  Future delete(String key,String docId) async {
    try{
      await firestore.
      collection(key).
      doc(docId).
      delete();
    } catch(e) {
      print('StorageService.delete: $e');
    }
    
  }

  Future<void> update(
    String key,
    String docId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await firestore.collection(key).doc(docId).update(updates);
    } catch (e) {
      print('StorageService.delete: $e');
    }
    
  }
  

}