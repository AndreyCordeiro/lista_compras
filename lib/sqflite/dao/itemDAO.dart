import 'package:lista_compras/model/carrinho.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/item.dart';
import '../banco/conexao.dart';

class ItemDAO {
  Future<bool> salvarItem(Item item) async {
    Database db = await Conexao.abrir();
    const sql =
        'INSERT INTO item (nome, descricao, quantidade, carrinho_id) VALUES (?,?,?, ?)';
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

  Future<bool> alterarItem(Item item) async {
    const sql =
        'UPDATE item SET nome=?, descricao=?, quantidade=? WHERE id_item = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
      sql,
      [
        item.nome,
        item.descricao,
        item.quantidade,
        item.id,
      ],
    );
    return linhasAfetadas > 0;
  }

  Future<bool> excluirItem(int id) async {
    late Database db;

    try {
      const sql = 'DELETE FROM item WHERE id_item = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);

      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      // db.close();
    }
  }

  Future<Item> consultarItem(int id) async {
    late Database db;

    try {
      const sql = 'SELECT * FROM item WHERE id_item = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;

      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }

      return Item(
        id: resultado['id'] as int,
        nome: resultado['nome'].toString(),
        descricao: resultado['descricao'].toString(),
        quantidade: double.parse(resultado['quantidade'].toString()),
        carrinho: resultado['id_carrinho'] as Carrinho,
      );
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      // db.close();
    }
  }

  Future<List<Map<String, Object?>>> listarItens() async {
    late Database db;

    try {
      const sql = 'SELECT * FROM item';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));

      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }

      return resultado;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      // db.close();
    }
  }

  Future<List<Map<String, Object?>>> listarItemPorCarrinho(
      int idCarrinho) async {
    late Database db;

    try {
      const sql = 'SELECT * FROM item WHERE carrinho_id =?';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado =
          (await db.rawQuery(sql, [idCarrinho]));

      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }

      return resultado;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      // db.close();
    }
  }
}
