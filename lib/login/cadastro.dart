import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/input-nome-email-senha.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroWidget();
}

class _TelaCadastroWidget extends State<TelaCadastro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
        ),
        body: const InputNomeEmailSenha(),
      ),
    );
  }
}

void _criarConta({
  required String email,
  required String senha,
  required String nomeUsuario,
}) {}
