import 'package:barber_shop_flutter/models/Servico.dart';
import 'package:barber_shop_flutter/views/widgets/ItemServico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class EditarServicos extends StatefulWidget {
  @override
  _EditarServicosState createState() => _EditarServicosState();
}

class _EditarServicosState extends State<EditarServicos> {
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _valorServicoController = TextEditingController();
  String? _id;

  Future<List<Servico>> _recuperarServicos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("servicos").get();

    List<Servico> listaServicos = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data()!;

      Servico servico = Servico();

      servico.id = item.id;
      servico.serviceName = dados["serviceName"];
      ;
      servico.valorServico = dados["valorServico"];

      listaServicos.add(servico);
    }

    return listaServicos;
  }

  _AtualizarServico({required Servico servicoSelecionado}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    String serviceName = _serviceNameController.text;
    String valorServico = _valorServicoController.text;

    //Atualizar

    servicoSelecionado.serviceName = serviceName;
    servicoSelecionado.valorServico = valorServico;

    DocumentSnapshot querySnapshot =
        await db.collection("servicos").doc(servicoSelecionado.id).get();

    _serviceNameController.clear();
    _valorServicoController.clear();
  }

  _exibirDialogUpdate(String? _id) async {
    print("chamou exibir dialog $_id");

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("servicos").doc(_id).get();

    Map<String, dynamic> dados = snapshot.data()!;
    _serviceNameController.text = dados["serviceName"];
    _valorServicoController.text = dados["valorServico"];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Atualizar Serviço"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _serviceNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Nome do Serviço",
                      hintText: "Digite um Serviço..."),
                ),
                TextField(
                  controller: _valorServicoController,
                  decoration: InputDecoration(
                      labelText: "Valor", hintText: "Valor do Serviço..."),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    //salvar
                    _atualizarServico(_id);
                    Navigator.pop(context);
                  },
                  child: Text("Atualizar", style: TextStyle(color: Colors.white),)
                  
              )
            ],
          );
        });
  }

  _atualizarServico(String? _id) {
    String nome = _serviceNameController.text;
    String valor = _valorServicoController.text;

    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "serviceName": nome,
      "valorServico": valor,
    };

    db.collection("servicos").doc(_id).update(dadosAtualizar);

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
                  children: <Widget>[
                    Text("Carregando Serviços"),
                    CircularProgressIndicator()
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
                      onPressedEditar: () {
                        _exibirDialogUpdate(servico.id);
                      },
                      onPressedRemover: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Confirmar"),
                                content:
                                    Text("Deseja realmente excluir o anúncio?"),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                   // style: TextButton.styleFrom(primary: Colors.red),
                                    //style: ButtonStyle(backgroundColor),

                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                    ),

                                    child: Text(
                                      "Remover",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      //_removerAnuncio(anuncio.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
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
