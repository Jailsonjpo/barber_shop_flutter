import 'dart:ui';

import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:barber_shop_flutter/views/widgets/CustomButtom.dart';
import 'package:barber_shop_flutter/views/widgets/CustomInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController(text: "j@g.com");
  TextEditingController _controllerPassword = TextEditingController(text: "123456");

 // bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _registerUser(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.password)
        .then((firebaseUser) {

      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  _loginUser(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.password)
        .then((firebaseUser) {

      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((error) {
      setState(() {
        _mensagemErro =
            "Erro ao autenticar o usuário, verifique o e-mail, senha e tente novamente!";
      });
    });
  }

  _validarCampos() {
    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.password = password;

          _loginUser(usuario);

      } else {
        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail! utilizando @";
      });
    }
  }

  Future _checkUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    _checkUserLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
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
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                SizedBox(height: 10,),
                CustomInput(
                  controller: _controllerPassword,
                  hint: "Senha",
                  obscure: true,
                ),

                SizedBox(height: 20,),

                CustomButtom(
                  texto: _textoBotao,
                  onPressed: () {
                    _validarCampos();
                  },
                ),

                SizedBox(height: 20,),

                CustomButtom(
                  texto: "Cadastrar",
                  onPressed: () {
                    Navigator.pushNamed(context, "/cadastrar");
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
