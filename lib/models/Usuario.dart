import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{

  String? _id;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String?  _photos;
  String? _descricao;
  bool? _status;
  String? _type;

  Usuario();
  
  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id          = documentSnapshot.id;
    this.name        = documentSnapshot["name"];
    this.email       = documentSnapshot["email"];
    this.phoneNumber = documentSnapshot["phoneNumber"];
    this.photos      = documentSnapshot["photos"];
    this.descricao   = documentSnapshot["descricao"];
    this.status      = documentSnapshot["status"];
    this.type        = documentSnapshot["type"];

  }

  Usuario.gerarId(){

  /*  FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usuarios = db.collection("usuarios");
    this.id = usuarios.doc().id;*/
   // this.photos = ["null"];

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {

      "id"          : this.id,
      "name"        : this.name,
      "email"       : this.email,
      "phoneNumber" : this.phoneNumber,
      "photos"      : this.photos,
      "descricao"   : this.descricao,
      "status"      : this.status,
      "type"        : this.type,
    };

    return map;
 }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }


  String? get photos => _photos;

  set photos(String? value) {
    _photos = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  bool? get status => _status;

  set status(bool? value) {
    _status = value;
  }

  String? get descricao => _descricao;

  set descricao(String? value) {
    _descricao = value;
  }

  String? get type => _type;

  set type(String? value) {
    _type = value;
  }
}