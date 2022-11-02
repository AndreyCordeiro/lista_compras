import 'package:flutter/material.dart';
import 'package:lista_compras/model/carrinho.dart';
import 'package:lista_compras/sqflite/dao/itemDAO.dart';

import '../model/item.dart';

class CadastroItem extends StatefulWidget {
  Carrinho carrinho;

  CadastroItem({Key? key, required this.carrinho}) : super(key: key);

  @override
  State<CadastroItem> createState() => _CadastroItemState();
}

class _CadastroItemState extends State<CadastroItem> {
  ItemDAO itemDAO = ItemDAO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Item item = Item(
      nome: '',
      descricao: '',
      quantidade: 0.0,
      carrinho: Carrinho(
        id: widget.carrinho.id,
        nome: widget.carrinho.nome,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Item"),
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
                  hintText: 'Nome do item',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do item!';
                  }
                  item.nome = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Descrição do item',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição do item!';
                  }
                  item.descricao = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Quantidade',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade!';
                  }
                  item.quantidade = double.parse(value);
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
                        itemDAO.salvarItem(item);

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
