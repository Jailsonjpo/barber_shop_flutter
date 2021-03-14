import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Servico.dart';
import 'package:flutter/material.dart';

class ItemServico extends StatelessWidget {
  Servico? servico;
  VoidCallback? onTapItem;
  VoidCallback? onPressedEditar;
  VoidCallback? onPressedRemover;

  ItemServico(
      {this.servico,
      this.onTapItem,
      this.onPressedEditar,
      this.onPressedRemover});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                          servico!.serviceName!,
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
                          servico!.valorServico!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
              if (this.onPressedEditar == null)
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff867638),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        textStyle: TextStyle(
                          color: Colors.white,
                        )
                    ),
                    onPressed: () {},

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.watch_later,
                          color: temaPadrao.cardColor,
                          size: 50,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // Icon(Icons.watch_later),
                        Text('AGENDAR',
                            style: TextStyle(
                                color: temaPadrao.cardColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              if (this.onPressedEditar != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.baseline,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff867638)),
                        ),
                        //padding: EdgeInsets.only(top:),
                        onPressed: this.onPressedEditar,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        //    padding: EdgeInsets.all(10),
                        onPressed: this.onPressedRemover,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
