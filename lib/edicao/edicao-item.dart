import 'package:flutter/material.dart';
import 'package:lista_compras/sqflite/dao/itemDAO.dart';

import '../model/item.dart';

class EdicaoItem extends StatefulWidget {
  Item item;

  EdicaoItem({
    super.key,
    required this.item,
  });

  @override
  State<EdicaoItem> createState() => _EdicaoItemState();
}

class _EdicaoItemState extends State<EdicaoItem> {
  ItemDAO itemDAO = ItemDAO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Item"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: widget.item.nome,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do item!';
                  }
                  widget.item.nome = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: widget.item.descricao,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição do item!';
                  }
                  widget.item.descricao = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                initialValue: widget.item.quantidade.toString(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantiade do item!';
                  }
                  widget.item.quantidade = double.parse(value);
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
                        itemDAO.alterarItem(widget.item);

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
