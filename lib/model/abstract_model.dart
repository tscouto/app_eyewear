import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AbstractModel {
  String get path;
  DocumentReference? docRef;

  bool excluido = false;

  Map<String, dynamic> toJson({bool fullJson = false});

  // Future<void> insert() async {
  //   if (docRef != null) {
  //     throw "Isso exige uma nova intacia de ${super.runtimeType}";
  //   } else {
  //     // se já tiver docRef, apenas seta os dados
  //     await docRef!.set(toJson());
  //   }
  // }

  Future<void> insert() async {
    if (docRef == null) {
      // Cria novo documento se não tiver docRef
      docRef = await FirebaseFirestore.instance.collection(path).add(toJson());
    } else {
      // Se já tiver docRef, apenas seta os dados
      await docRef!.set(toJson());
    }
  }

  Future<void> update() async {
    if (docRef == null) {
      throw "Isso exige uma nova instância de ${super.runtimeType}";
    }

    try {
      var data = toJson();

      data.removeWhere(
        (key, value) =>
            key.startsWith('fk_') && value is String && value.isEmpty,
      );

      await FirebaseFirestore.instance.doc('$path/${docRef!.id}').update(data);
    } on FirebaseException catch (e) {
      throw "Erro ao atualizar ${super.runtimeType}: ${e.message}";
    }
  }

  Future<void> delete({bool logico = true}) async {
    if (docRef == null) {
      throw "'${super.runtimeType}'.docRef não pode ser null para um delete";
    }

    try {
      if (logico) {
        excluido = true;
        await update();
      } else {
        await FirebaseFirestore.instance.doc('$path/${docRef!.id}').delete();
      }
    } on FirebaseException catch (e) {
      throw "Erro ao deletar ${super.runtimeType}: ${e.message}";
    }
  }

  DocumentReference? referenceFromModel(AbstractModel? model) {
    return model?.docRef;
  }

  @override
  String toString() {
    return toJson(fullJson: true).toString();
  }
}
