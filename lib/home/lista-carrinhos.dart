import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_compras/home/lista-itens.dart';
import 'package:lista_compras/sqflite/dao/carrinhoDAO.dart';
import 'package:lista_compras/sqflite/dao/itemDAO.dart';

import '../cadastro/cadastro-carrinho.dart';
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
  ItemDAO itemDAO = ItemDAO();

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
                        builder: (context) => ListaItens(carrinho: carrinho),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
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
                        IconButton(
                          icon: const Icon(Icons.delete_forever,
                              color: Colors.red),
                          onPressed: () async {
                            await carrinhoDAO.excluirCarrinho(carrinho.id);
                            await itemDAO.excluirItensDoCarrinho(carrinho.id);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
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
              builder: (context) => const CadastroCarrinho(),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
