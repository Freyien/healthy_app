import 'package:cloud_firestore/cloud_firestore.dart';

extension QuerydocumentsnapshotExtensions
    on QueryDocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> get dataWithId {
    Map<String, dynamic> data = this.data();
    data['id'] = this.id;

    return data;
  }
}
