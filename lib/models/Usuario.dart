import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{

  String _id;
  String _name;
  String _email;
  String _phoneNumber;
  String _password;
  List<String> _photos;
  bool _status;

  Usuario();
  
  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id          = documentSnapshot.id;
    this.name        = documentSnapshot["name"];
    this.email       = documentSnapshot["email"];
    this.phoneNumber = documentSnapshot["phoneNumber"];
    this.photos      = List<String>.from(documentSnapshot["photos"]); //recupera como map mas precisa conterter para List
    this.status      = documentSnapshot["status"];
    
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {

      "id"          : this.id,
      "name"        : this.name,
      "email"       : this.email,
      "phoneNumber" : this.phoneNumber,
      "photos"      : this.photos,
      "status"      : this.status,
    };

    return map;
 }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<String> get photos => _photos;

  set photos(List<String> value) {
    _photos = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }
}