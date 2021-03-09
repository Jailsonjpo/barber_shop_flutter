import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Servico.dart';
import 'package:flutter/material.dart';

class ItemServico extends StatelessWidget {
  Servico servico;
  VoidCallback onTapItem;
  /* VoidCallback onPressedRemover;*/

  ItemServico({this.servico, this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        color: Color(0xff242424),
          child: Padding(
            padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          servico.serviceName,
                          style: TextStyle(
                              color: Color(0xffc6c6c6),
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          servico.valorServico,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                  )),
              Expanded(
                flex: 1,

                 child: RaisedButton(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                       //side: BorderSide(color: Colors.white)
                   ),
                   padding: EdgeInsets.only(top: 8, bottom: 8),
                   onPressed: () {},
                   color: temaPadrao.textSelectionColor,
                   textColor: Colors.white,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Icon(Icons.watch_later, color: temaPadrao.cardColor, size: 50,),
                      SizedBox(height: 10,),
                      // Icon(Icons.watch_later),
                       Text('AGENDAR',style: TextStyle(
                           color: temaPadrao.cardColor,
                           fontSize: 14,
                           fontWeight: FontWeight.w800)),
                     ],
                   ),
                 ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
