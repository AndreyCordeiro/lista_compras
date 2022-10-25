import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CadastroItem extends StatefulWidget {
  const CadastroItem({Key? key}) : super(key: key);

  @override
  State<CadastroItem> createState() => _CadastroItemState();
}

class _CadastroItemState extends State<CadastroItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic id;
  String? nome;
  String? descricao;
  String? quantidade;

  @override
  Widget build(BuildContext context) {
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
                  nome = value;
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
                  descricao = value;
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
                  quantidade = value;
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
                        _salvar(nome!, descricao!, quantidade!, id);
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

  Future<int> _salvar(String nome, String descricao, String quantidade,
      [int? id]) async {
    String path = join(await getDatabasesPath(), 'shopping_list');
    Database dataBase = await openDatabase(path, version: 1);

    String sql;
    Future<int> linhasAfetadas;

    if (id == null) {
      sql = "INSERT INTO item (nome, descricao, quantidade) VALUES (?, ?, ?)";
      linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao, quantidade]);
    } else {
      sql =
          "UPDATE item SET nome = ?, descricao = ?, quantidade = ? WHERE id = ?";
      linhasAfetadas = dataBase.rawInsert(sql, [nome, descricao, quantidade]);
    }
    return linhasAfetadas;
  }
}
