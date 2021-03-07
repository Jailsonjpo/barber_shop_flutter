import 'package:barber_shop_flutter/main.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  CustomButtom(
      {@required this.texto, this.corTexto = Colors.white, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)
        ),
        child: Text(this.texto,
        style: TextStyle(color: this.corTexto, fontSize: 20
        ),
        ),
        color: temaPadrao.textSelectionColor,

        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        onPressed: this.onPressed,

    );
  }
}
