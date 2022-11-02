import 'package:flutter/material.dart';
import 'package:lista_compras/sqflite/dao/carrinhoDAO.dart';

import '../model/carrinho.dart';

class EdicaoCarrinho extends StatefulWidget {
  Carrinho carrinho;

  EdicaoCarrinho({Key? key, required this.carrinho}) : super(key: key);

  @override
  State<EdicaoCarrinho> createState() => _EdicaoCarrinhoState();
}

class _EdicaoCarrinhoState extends State<EdicaoCarrinho> {
  CarrinhoDAO carrinhoDAO = CarrinhoDAO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Carrinho"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: widget.carrinho.nome,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do carrinho!';
                  }
                  widget.carrinho.nome = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        carrinhoDAO.alterarCarrinho(widget.carrinho);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
