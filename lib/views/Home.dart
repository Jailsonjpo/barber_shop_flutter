import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> itensMenu = [];
  Usuario _usuario;
  String _tipoUsuario;

  /*List<Widget> _getListImages() {

  }*/

  _choiceMenuItem(String itemChosen) {
    switch (itemChosen) {
      case "Configurações":
        Navigator.pushNamed(context, "/configuracoes");
        break;

      case "Perfil":
        _logout();
       break;

      case "Deslogar":
              _logout();
              break;

    }
  }

  _redirecionaPainelPorTipoUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    print("tipo ${usuarioLogado.uid.toString()}");
    FirebaseFirestore db = FirebaseFirestore.instance;

  //  print("tipo ${usuarioLogado.uid}");

  /*  DocumentSnapshot snapshot = await db.collection("usuarios").doc(usuarioLogado.uid).get();

    Map<String, dynamic> dados = snapshot.data();

    _tipoUsuario = dados["type"].toString();*/

   // print("tipo ${_tipoUsuario}");

    //return _tipoUsuario;

   // _itemsmenu(_tipoUsuario.toString());

   /* switch(tipoUsuario){

      case "C":
        itensMenu = await ["Configurações", "Deslogar"];
        break;

      case "P":
        itensMenu = await ["Configurações", "Perfil", "Deslogar"];
        break;

    }*/

  }

  Future _itemsmenu() async {

    itensMenu = await ["Configurações", "Deslogar"];
    /*if (_tipo == "C") {
    itensMenu = await ["Configurações", "Deslogar"];
    }else{
    itensMenu = await ["Configurações", "Perfil", "Deslogar"];
    }*/

  }


 /* Future<void> _checkUserLogged() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('usuarios').doc(usuarioLogado);

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    _usuario = allData;

    if (allData) {

    }

    print("motrar todos os dados: ${allData}");
  }*/



 /* Future _verificaUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios").doc(usuarioLogado);

    print("usuario: ${usuarioLogado}");

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meus Anúncios", "Deslogar"];
    }
  }
*/
 /* Future _checkUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

    usuarioLogado.

    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }*/

  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/");
  }

  @override
  void initState() {
    // TODO: implement initState
    _redirecionaPainelPorTipoUsuario();
  //  _checkUserLogged();
    _itemsmenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(
        backgroundColor: temaPadrao.primaryColor,
        centerTitle: true,
        title: Text("Barber Shop"),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
              onSelected: _choiceMenuItem,
              itemBuilder: (context) {
                return itensMenu.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              })
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Carousel(
                        dotSize: 8,
                        dotBgColor: Colors.transparent,
                        dotColor: Colors.red,
                        autoplay: false,
                        dotIncreasedColor: Colors.red,

                        images: [
                          NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcC-mOq3P1Lr6LQxE8gsXdDu084zUCd8gxVw&usqp=CAU',
                          ),
                          NetworkImage(
                              'http://hinova.com.br/wp-content/uploads/2017/07/Barbearia.jpg'),
                          NetworkImage(
                              'https://webtrends.net.br/wp-content/uploads/2020/10/Como-atrair-clientes-para-barbearia.png'),

                          //ExactAssetImage("images/logo.jpg"),
                        ],

                        //dotIncreasedColor: temaPadrao.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
              Container(
                color: temaPadrao.cardColor,

                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Promoção: Corte R\$\ 29,90",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Quicksand', color: temaPadrao.textSelectionColor,)),
                  ],
                )),
            SizedBox(height: 12.0),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 4.0,
                shrinkWrap: true,
                children: [
                  _buildCard("Serviços", "Disponível", 1, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLrsb-5LHk8zwyG9JclrtiIeExBhbRWwDXRA&usqp=CAU"),
                  _buildCard("Profissional", "Away", 2, "https://png.pngtree.com/png-clipart/20190611/original/pngtree-cartoons-depicting-barber-png-image_2820272.jpg"),
                  _buildCard("Agendar", "Away", 3, "https://img.elo7.com.br/product/zoom/331E089/agenda-2020-profissao-barber-shop-barbeiro-cabeleireiro.jpg"),
                  _buildCard("Preços", "Available", 4, "https://img1.gratispng.com/20181128/rj/kisspng-hair-clipper-barber-clip-art-vector-graphics-beaut-hair-salon-badge-svg-png-icon-free-download-62-1-5bfee6604d2b83.9542469815434317763161.jpg"),

                ],
              ),
            ),
            //),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String name, String status, int cardIndex, String imagem) {
    return GestureDetector(

        child: Card(
          color: temaPadrao.cardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          elevation: 7.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12.0),
              Stack(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.green,
                          image: DecorationImage(
                              image: NetworkImage(
                                  imagem
                              )
                          )
                      ),
                    ),
                  ]),
              SizedBox(height: 8.0),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(height: 20.0),
              Expanded(
                  child: Container(
                      width: 175.0,
                      decoration: BoxDecoration(
                        color: temaPadrao.textSelectionColor,
                        borderRadius: BorderRadius.only
                          (
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)
                        ),
                      ),
                      child: Center(
                        child: Text('Detalhes',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Quicksand'
                          ),
                        ),
                      )
                  )
              )
            ],
          ),
          margin: cardIndex.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    ),

      onTap: (){
          Navigator.pushNamed(context, "/$name");
      },
      );

  }
}
