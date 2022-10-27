import 'package:lista_compras/model/carrinho.dart';
import 'package:sqflite/sqflite.dart';

import '../model/item.dart';
import 'conexao.dart';

class ItemDAO {
  Future<bool> salvar(Item item) async {
    Database db = await Conexao.abrir();
    const sql =
        'INSERT INTO item (nome, descricao, quantidade, id_carrinho) VALUES (?,?,?, ?)';
    var linhasAfetadas = await db.rawInsert(
      sql,
      [
        item.nome,
        item.descricao,
        item.quantidade,
        item.carrinho.id,
      ],
    );
    return linhasAfetadas > 0;
  }

  Future<bool> alterar(Item item) async {
    const sql =
        'UPDATE item SET nome=?, descricao=?, quantidade=?, id_carrinho=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
      sql,
      [item.nome, item.descricao, item.quantidade, item.carrinho.id, item.id],
    );
    return linhasAfetadas > 0;
  }

  Future<bool> excluir(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM item WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      db.close();
    }
  }

  Future<Item> consultar(int id) async {
    late Database db;
    try {
      const sql = 'SELECT * FROM item WHERE id = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }
      Item item = Item(
        id: resultado['id'] as int,
        nome: resultado['nome'].toString(),
        descricao: resultado['descricao'].toString(),
        quantidade: double.parse(resultado['quantidade'].toString()),
        carrinho: resultado['id_carrinho'] as Carrinho,
      );
      return item;
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      db.close();
    }
  }

  Future<List<Item>> listar() async {
    late Database db;
    try {
      const sql = 'SELECT * FROM item';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }
      List<Item> itens = resultado.map((linha) {
        return Item(
          id: linha['id'] as int,
          nome: linha['nome'].toString(),
          descricao: linha['descricao'].toString(),
          quantidade: double.parse(linha['quantidade'].toString()),
          carrinho: linha['id_carrinho'] as Carrinho,
        );
      }).toList();
      return itens;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      db.close();
    }
  }
}
