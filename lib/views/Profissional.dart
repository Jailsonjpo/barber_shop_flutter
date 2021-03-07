import 'package:barber_shop_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:barber_shop_flutter/views/widgets/ItemProfissional.dart';

class Profissional extends StatefulWidget {
  @override
  _ProfissionalState createState() => _ProfissionalState();
}

class _ProfissionalState extends State<Profissional> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario> listaUsuarios = List();
    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data();
     // if (dados["email"] == _emailUsuarioLogado) continue;

      Usuario usuario = Usuario();
      usuario.id = item.id;
      usuario.email = dados["email"];
      usuario.name = dados["name"];
      usuario.photos = dados["photos"];
      usuario.status = dados["status"];
      usuario.descricao = dados["descricao"];
      usuario.phoneNumber = dados["phoneNumber"];

      listaUsuarios.add(usuario);

    //  print("${listaUsuarios.toString()}");

    }

    return listaUsuarios;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;

  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(
        backgroundColor: temaPadrao.accentColor,
          title: Text("Profissionais", style: TextStyle(fontSize: 20),)

      ),
        body: FutureBuilder<List<Usuario>>(
        future: _recuperarContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando contatos"),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, indice) {
                    List<Usuario> listaItens = snapshot.data;
                    Usuario usuario = listaItens[indice];

                    return ItemProfissional(
                      usuario: usuario,
                      onTapItem: () {
                        Navigator.pushNamed(
                            context, "/detalhes",
                            arguments: usuario);
                      },
                    );

                  });
              break;
          }
          return Container();
        },
    ),
      );
  }
}

