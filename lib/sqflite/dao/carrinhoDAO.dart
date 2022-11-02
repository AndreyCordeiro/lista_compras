import 'package:lista_compras/model/carrinho.dart';
import 'package:sqflite/sqflite.dart';

import '../banco/conexao.dart';

class CarrinhoDAO {
  Future<bool> salvarCarrinho(Carrinho carrinho) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO carrinho (nome) VALUES (?)';
    var linhasAfetadas = await db.rawInsert(
      sql,
      [
        carrinho.nome,
      ],
    );
    return linhasAfetadas > 0;
  }

  Future<bool> alterarCarrinho(Carrinho carrinho) async {
    const sql = 'UPDATE carrinho SET nome=? WHERE id_carrinho = ?';
    Database db = await Conexao.abrir();

    var linhasAfetadas = await db.rawUpdate(
      sql,
      [
        carrinho.nome,
        carrinho.id,
      ],
    );
    return linhasAfetadas > 0;
  }

  Future<bool> excluirCarrinho(int id) async {
    late Database db;

    try {
      const sql = 'DELETE FROM carrinho WHERE id_carrinho = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);

      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      // db.close();
    }
  }

  Future<Carrinho> consultarCarrinho(int id) async {
    late Database db;

    try {
      const sql = 'SELECT * FROM carrinho WHERE id_carrinho = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;

      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }

      return Carrinho(
        id: resultado['id_carrinho'] as int,
        nome: resultado['nome'].toString(),
      );
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      // db.close();
    }
  }

  Future<List<Carrinho>> listarCarrinho() async {
    late Database db;

    try {
      const sql = 'SELECT * FROM carrinho';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));

      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }

      List<Carrinho> itens = resultado.map((linha) {
        return Carrinho(
          id: linha["id_carrinho"] as int,
          nome: linha["nome"].toString(),
        );
      }).toList();
      return itens;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      // db.close();
    }
  }
}
