import 'package:flutter/material.dart';

import '../componentes/input-email-senha.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginWidget();
}

class _TelaLoginWidget extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: const <Widget>[
              CircleAvatar(
                radius: 160,
                backgroundImage: AssetImage('lib/images/politica-privacidade.png'),
              ),
              InputEmailSenha(),
            ],
          ),
        ),
      ),
    );
  }
}
