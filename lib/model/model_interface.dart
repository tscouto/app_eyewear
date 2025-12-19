import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ModelInterface {
  DocumentReference get docRef;
  bool get excluido;
}
