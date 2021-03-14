import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Servico.dart';
import 'package:barber_shop_flutter/views/widgets/ItemServico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Servicos extends StatefulWidget {
  @override
  _ServicosState createState() => _ServicosState();
}

class _ServicosState extends State<Servicos> {

  Future<List<Servico>> _recuperarServicos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("servicos").get();

    List<Servico> listaServicos = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data()!;

      Servico servico = Servico();

      servico.id           = item.id;
      servico.serviceName  = dados["serviceName"];;
      servico.valorServico = dados["valorServico"];

      listaServicos.add(servico);
    }

    return listaServicos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(

        leading: new IconButton(
          icon: new Icon(Icons.west, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),

        // iconTheme: IconThemeData(color: temaPadrao.textSelectionColor),
        title: Text("Serviços"),
        backgroundColor: temaPadrao.accentColor,
      ),
      body: FutureBuilder<List<Servico>>(
        future: _recuperarServicos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Carregando Serviços", style: TextStyle(

                    fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white
                    ),),
                    CircularProgressIndicator(
                      backgroundColor: temaPadrao.textSelectionColor,
                    )
                  ],
                ),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, indice) {
                    List<Servico> listaItens = snapshot.data!;
                    Servico servico = listaItens[indice];

                    return ItemServico(
                      servico: servico,
                      onTapItem: () {
                        Navigator.pushNamed(context, "/servicos",
                            arguments: servico);
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
