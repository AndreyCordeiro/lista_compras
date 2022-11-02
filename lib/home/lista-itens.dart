import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_compras/edicao/edicao-item.dart';
import 'package:lista_compras/sqflite/dao/itemDAO.dart';

import '../cadastro/cadastro-item.dart';
import '../model/carrinho.dart';
import '../model/item.dart';

class ListaItens extends StatefulWidget {
  Carrinho carrinho;

  ListaItens({Key? key, required this.carrinho}) : super(key: key);

  @override
  State<ListaItens> createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  final _random = Random();
  ItemDAO itemDAO = ItemDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Itens'),
      ),
      body: FutureBuilder(
        future: itemDAO.listarItemPorCarrinho(widget.carrinho.id),
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
              var itemIndex = listaItens[index];

              Item item = Item(
                id: itemIndex['id_item'] as int,
                nome: itemIndex['nome'].toString(),
                descricao: itemIndex['descricao'].toString(),
                quantidade: double.parse(itemIndex['quantidade'].toString()),
                carrinho: Carrinho(id: null, nome: ''),
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
                      listaItens[index]['nome']
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),
                    ),
                  ),
                  title: Text(item.nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EdicaoItem(item: item),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  subtitle: Text(
                    item.descricao,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: () async {
                      await itemDAO.excluirItem(item.id);
                      setState(() {});
                    },
                  ),
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
              builder: (context) => CadastroItem(
                carrinho: widget.carrinho,
              ),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
