import 'dart:async';
import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:barber_shop_flutter/views/widgets/ItemProfissional.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profissional extends StatefulWidget {
  @override
  _ProfissionalState createState() => _ProfissionalState();
}

class _ProfissionalState extends State<Profissional> {

  final _controller = StreamController<QuerySnapshot>.broadcast();


  Future<List<Usuario>> _recuperarProfissionais() async{

    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario> listaUsuarios = List();

    for (DocumentSnapshot item in querySnapshot.docs) {

      var dados = item.data();

      Usuario usuario     = Usuario();
      usuario.id          = item.id;
      usuario.email       = dados["email"];
      usuario.name        = dados["name"];
      usuario.phoneNumber = dados["phoneNumber"];
      usuario.photos = dados["photos"];
      listaUsuarios.add(usuario);

      print("saida de dados: ${listaUsuarios.toString()}");

    }
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerProfissionais() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Stream<QuerySnapshot> stream = db.collection("usuarios").snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adicionarListenerProfissionais();

  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados = Center(
      child: Column(
        children: [
          Text("Carregando Profissioanis"),
          CircularProgressIndicator()
        ],
      ),
    );

    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(title: Text("Profissional"),
      backgroundColor: temaPadrao.accentColor,

      ),

      body: Container(

          child: Column(
            children: [
            StreamBuilder(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:

                      return carregandoDados;
                      break;

                    case ConnectionState.active:
                    case ConnectionState.done:
                      QuerySnapshot querySnapshot = snapshot.data;

                      if (querySnapshot.docs.length == 0) {
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "nenhum Profissional encontrado! :(",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }

                      return Expanded(
                          child: ListView.builder(
                              itemCount: querySnapshot.docs.length,
                              itemBuilder: (_, indice) {
                                List<DocumentSnapshot> usuarios =
                                querySnapshot.docs.toList();
                                DocumentSnapshot documentSnapshot =
                                usuarios[indice];
                                Usuario usuario = Usuario.fromDocumentSnapshot(
                                    documentSnapshot);

                                return ItemProfissional(
                                  usuario: usuario,
                                  onTapItem: () {
                                    Navigator.pushNamed(
                                        context, "/detalhes",);
                                  },
                                );
                              }));
                  }

                  return Container();
                }),
            ],
          )


      ),


    );
  }
}
