import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_compras/home/lista-itens.dart';
import 'package:lista_compras/sqflite/dao/carrinhoDAO.dart';

import '../cadastro/cadastro-item.dart';
import '../edicao/edicao-carrinho.dart';
import '../model/carrinho.dart';

class ListaCarrinhos extends StatefulWidget {
  const ListaCarrinhos({Key? key}) : super(key: key);

  @override
  State<ListaCarrinhos> createState() => _ListaCarrinhosState();
}

class _ListaCarrinhosState extends State<ListaCarrinhos> {
  final _random = Random();
  CarrinhoDAO carrinhoDAO = CarrinhoDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carrinhos'),
      ),
      body: FutureBuilder(
        future: carrinhoDAO.listarCarrinho(),
        builder: (context, AsyncSnapshot<List<Carrinho>> dadosRetornados) {
          if (!dadosRetornados.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var listaCarrinhos = dadosRetornados.data!;

          return ListView.builder(
            itemCount: listaCarrinhos.length,
            itemBuilder: (context, index) {
              var carrinhoIndex = listaCarrinhos[index];

              Carrinho carrinho = Carrinho(
                id: carrinhoIndex.id as int,
                nome: carrinhoIndex.nome,
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
                      listaCarrinhos[index]
                          .nome
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),
                    ),
                  ),
                  title: Text(carrinho.nome),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListaItens(carrinhoId: carrinho.id),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  trailing: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EdicaoCarrinho(carrinho: carrinho),
                            ),
                          ).then((value) => setState(() {}));
                        },
                      ),
                    ],
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
              builder: (context) => const CadastroItem(),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
