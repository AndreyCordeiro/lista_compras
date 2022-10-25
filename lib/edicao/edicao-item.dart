import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nome;
  String? descricao;
  String? quantidade;

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
                  nome = value;
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
                  descricao = value;
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: widget.item.quantidade.toString(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantiade do item!';
                  }
                  quantidade = value;
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
                        _atualizar(
                          nome!,
                          descricao!,
                          quantidade!,
                          widget.item.id,
                        );
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

  Future<int> _atualizar(String nome, String descricao, String quantidade,
      [int? id]) async {
    String path = join(await getDatabasesPath(), 'shopping_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> linhasAfetadas;

    sql =
        "UPDATE item SET nome = ?, descricao = ?, quantidade = ? WHERE id = ?";
    linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao, quantidade, id]);

    return linhasAfetadas;
  }
}
