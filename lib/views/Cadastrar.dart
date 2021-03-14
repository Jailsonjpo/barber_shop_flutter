import 'dart:ui';

import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:barber_shop_flutter/views/widgets/CustomButtom.dart';
import 'package:barber_shop_flutter/views/widgets/CustomInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cadastrar extends StatefulWidget {
  @override
  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _type = "C";
  Usuario? _usuario;

  _registerUser(Usuario usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email!, password: usuario.password!)
        .then((firebaseUser) {

      //Salvar dados do usuário
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("usuarios").doc(firebaseUser.user!.uid).set(usuario.toMap());

      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    }).catchError((error) {
      print("erro app" + error.toString());
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });
    });
  }

  _validarCampos() {
    //Recuperar dados dos campos

    String name = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    //if (nome.isNotEmpty && nome.length > 3) {
    if (name.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (password.isNotEmpty && password.length > 5) {
          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario  = Usuario();
          usuario.id       = usuario.id;
          usuario.name     = name;
          usuario.email    = email;
          usuario.password = password;
         // usuario.photos   = photos;
          usuario.type     = _type;
          usuario.status   = true;
          _registerUser(usuario);
        } else {
          setState(() {
            _mensagemErro =
                "Preencha a senha! A senha deve ter pelo menos 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o E-mail! utilizando @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o nome!";
      });
    }
  }

  /*Future _checkUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }*/

  @override
  void initState() {
  //  _checkUserLogged();
   // _usuario = Usuario.gerarId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(
        title: Text("Cadastrar Cliente ou Profissional"),
        backgroundColor: temaPadrao.accentColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "images/logo.jpg",
                    width: 200,
                    height: 150,
                  ),
                ),
                CustomInput(
                  controller: _controllerNome,
                  hint: "Nome",
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomInput(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  type: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomInput(
                  controller: _controllerPassword,
                  hint: "Senha",
                  obscure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cliente",
                      style: TextStyle(
                        color: temaPadrao.textSelectionColor,
                      ),
                    ),
                    Switch(
                        activeColor: temaPadrao.textSelectionColor,
                        inactiveThumbColor: Colors.blue,
                        value: _cadastrar,
                        onChanged: (bool valor) {
                          setState(() {
                          _cadastrar = valor;
                          _type = "C";

                          if (_cadastrar) {
                          _type = "P";
                          }

                          print("tipo $_type");

                          });
                          }),

                    Text(
                      "Profissional",
                      style: TextStyle(
                        color: temaPadrao.textSelectionColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                CustomButtom(
                  texto: "Cadastrar",
                  onPressed: () {
                    _validarCampos();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(_mensagemErro,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
