import 'package:barber_shop_flutter/views/widgets/CustomInput.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller_email = TextEditingController();
  TextEditingController _controller_password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
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
                  controller: _controller_email,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                CustomInput(
                    controller: _controller_password,
                    hint: "Senha",
                    obscure: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
