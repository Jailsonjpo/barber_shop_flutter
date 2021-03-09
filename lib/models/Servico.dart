
import 'package:cloud_firestore/cloud_firestore.dart';

class Servico{

  String _id;
  String _serviceName;
  String _valorServico;

  Servico();


  Servico.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id           = documentSnapshot.id;
    this.serviceName  = documentSnapshot["serviceName"];
    this.valorServico = documentSnapshot["valorServico"];

  }

   Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {

    "id"           : id,
    "ServiceName"  : "this.serviceName",
    "valorServico" : "this.valorServico"

  };

  return map;

  }

  String get valorServico => _valorServico;

  set valorServico(String value) {
    _valorServico = value;
  }

  String get serviceName => _serviceName;

  set serviceName(String value) {
    _serviceName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}