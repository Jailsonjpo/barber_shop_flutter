import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:flutter/material.dart';


class ItemProfissional extends StatelessWidget {

  Usuario usuario;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemProfissional({
    this.usuario,
    this.onTapItem,
    this.onPressedRemover

});

  @override
  Widget build(BuildContext context) {

   // print("name ${usuario.name}");

    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        color: Color(0xff242424),
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(children: [

              SizedBox(
            width: 120,
            height: 120,
             child: Stack(
               children: [
                 Container(
                   child: CircleAvatar(
                       maxRadius: 60,
                       backgroundImage:
                       usuario.photos != null
                           ? NetworkImage(usuario.photos)
                           : NetworkImage("https://banner2.cleanpng.com/20180410/bbw/kisspng-avatar-user-medicine-surgery-patient-avatar-5acc9f7a7cb983.0104600115233596105109.jpg")
                   ),
                 ),

                 Container(
                   margin: EdgeInsets.only(left: 80.0),
                   height: 20.0,
                   width: 20.0,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30.0),
                       color: usuario.status ? Colors.green : Colors.amber,
                       border: Border.all(
                           color: Colors.white,
                           style: BorderStyle.solid,
                           width: 2.0
                       )
                   ),
                 )
               ],

             )


        ),

        Expanded(
          flex: 3,
          child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(usuario.name,
            style: TextStyle(
              color: Color(0xffc6c6c6),
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Text("${usuario.email}", style: TextStyle(
                color: Color(0xff867638),

            ),),
          ],),

        )
        ),
              if(this.onPressedRemover != null) Expanded(
          flex: 1,
          child: FlatButton(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              onPressed: this.onPressedRemover,
              child: Icon(Icons.delete, color: Colors.white,),
              ),

        )
          ],),


        ),

      ),

    );
  }
}
