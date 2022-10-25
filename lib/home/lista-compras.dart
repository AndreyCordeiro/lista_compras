import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_compras/edicao/edicao-item.dart';
import 'package:lista_compras/model/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../cadastro/cadastro-item.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({Key? key}) : super(key: key);

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Itens'),
      ),
      body: FutureBuilder(
        future: _buscarDados(),
        builder: (context,
            AsyncSnapshot<List<Map<String, Object?>>> dadosRetornados) {
          if (!dadosRetornados.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var listaItens = dadosRetornados.data!;

          return ListView.builder(
            itemCount: listaItens.length,
            itemBuilder: (context, index) {
              var item = listaItens[index];
              Item ItemObject = Item(
                id: item['id'],
                nome: item['nome'].toString(),
                descricao: item['descricao'].toString(),
                quantidade: double.parse(
                  item['quantidade'].toString(),
                ),
              );

              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors
                            .primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                    child: Text(
                      listaItens[index]["nome"]
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),
                    ),
                  ),
                  title: Text(
                    item['nome'].toString(),
                  ),
                  subtitle: Text(
                    item['descricao'].toString(),
                  ),
                  trailing: Text(
                    'qtd. ${item['quantidade'].toString()}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EdicaoItem(item: ItemObject),
                      ),
                    ).then((value) => setState(() {}));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroItem(),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }

  Future<List<Map<String, Object?>>> _buscarDados() async {
    String path = join(await getDatabasesPath(), 'shopping_list');
    // deleteDatabase(path);
    Database dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
          CREATE TABLE item (
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          descricao TEXT NOT NULL,
          quantidade TEXT NOT NULL)
        ''');
        db.execute(
            'INSERT INTO item (nome, descricao, quantidade) VALUES ("Miojo", "macarrão instantâneo", "4")');
        db.execute(
            'INSERT INTO item (nome, descricao, quantidade) VALUES ("Macarrão", "Macarrão pacote", "2")');
      },
    );
    List<Map<String, Object?>> retorno =
        await dataBase.rawQuery('SELECT * FROM item');
    return retorno;
  }
}
