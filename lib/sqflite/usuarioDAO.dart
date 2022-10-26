import 'package:lista_compras/model/usuario.dart';
import 'package:sqflite/sqflite.dart';

import 'conexao.dart';

class UsuarioDAO {
  Future<bool> salvar(Usuario usuario) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO usuario (nome, email, senha) VALUES (?,?,?)';
    var linhasAfetadas =
        await db.rawInsert(sql, [usuario.nome, usuario.email, usuario.senha]);
    return linhasAfetadas > 0;
  }

  Future<bool> alterar(Usuario usuario) async {
    const sql = 'UPDATE usuario SET nome=?, email=?, senha=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
        sql, [usuario.nome, usuario.email, usuario.senha, usuario.id]);
    return linhasAfetadas > 0;
  }

  Future<bool> excluir(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM usuario WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      db.close();
    }
  }

  Future<Usuario> consultar(int id) async {
    late Database db;
    try {
      const sql = 'SELECT * FROM usuario WHERE id = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }
      Usuario usuario = Usuario(
          id: resultado['id'] as int,
          nome: resultado['nome'].toString(),
          email: resultado['email'].toString(),
          senha: resultado['senha'].toString());
      return usuario;
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      db.close();
    }
  }
}
