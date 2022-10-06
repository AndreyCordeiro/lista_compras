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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: const InputEmailSenha(),
    );
  }
}
