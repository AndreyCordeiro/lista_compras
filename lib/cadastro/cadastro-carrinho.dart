import 'package:flutter/material.dart';
import 'package:lista_compras/model/carrinho.dart';

import '../sqflite/dao/carrinhoDAO.dart';

class CadastroItem extends StatefulWidget {
  const CadastroItem({Key? key}) : super(key: key);

  @override
  State<CadastroItem> createState() => _CadastroItemState();
}

class _CadastroItemState extends State<CadastroItem> {
  CarrinhoDAO carrinhoDAO = CarrinhoDAO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Carrinho carrinho;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Carrinho"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome do carrinho',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do carrinho!';
                  }
                  carrinho.nome = value;
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
                        carrinhoDAO.salvarCarrinho(carrinho);
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
