import 'package:lista_compras/model/usuario.dart';
import 'package:sqflite/sqflite.dart';

import '../banco/conexao.dart';

class UsuarioDAO {
  Future<bool> salvarUsuario(Usuario usuario) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO usuario (nome, email, senha) VALUES (?,?,?)';
    var linhasAfetadas =
        await db.rawInsert(sql, [usuario.nome, usuario.email, usuario.senha]);
    return linhasAfetadas > 0;
  }

  Future<bool> alterarUsuario(Usuario usuario) async {
    const sql = 'UPDATE usuario SET nome=?, email=?, senha=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
        sql, [usuario.nome, usuario.email, usuario.senha, usuario.id]);
    return linhasAfetadas > 0;
  }

  Future<bool> excluirUsuario(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM usuario WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      // db.close();
    }
  }

  Future<bool> consultarUsuario(String email) async {
    late Database db;
    late bool emailExiste;

    try {
      const sql = 'SELECT * FROM usuario WHERE email = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [email])).first;

      if (resultado.isEmpty) {
        emailExiste = false;
      } else {
        emailExiste = true;
      }

      return emailExiste;
    } catch (e) {
      throw Exception("Erro ao consultar Usuário");
    } finally {
      // db.close();
    }
  }
}
