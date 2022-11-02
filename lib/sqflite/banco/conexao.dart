import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const String _tabelaItem = '''
       CREATE TABLE item (
      id_item INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      quantidade TEXT NOT NULL,
      carrinho_id INTEGER NOT NULL,
      FOREIGN KEY(carrinho_id) REFERENCES carrinho(id_carrinho)
      )
  ''';

  static const String _tabelaCarrinho = '''
      CREATE TABLE carrinho (
                id_carrinho INTEGER NOT NULL PRIMARY KEY,
                nome TEXT NOT NULL
            )
  ''';

  static const String _tabelaUsuario = '''
     CREATE TABLE usuario (
          id_usuario INTEGER NOT NULL PRIMARY KEY,
          nome TEXT NOT NULL,
          email TEXT NOT NULL,
          senha TEXT NOT NULL
      )
  ''';

  static const String _insercao1 =
      "INSERT INTO carrinho (nome) VALUES ('Compras do mês')";

  static const String _insercao2 =
      "INSERT INTO carrinho (nome) VALUES ('Loja de roupas')";

  static Database? _db;

  static Future<Database> abrir() async {
    if (_db == null) {
      String caminho = join(await getDatabasesPath(), 'banco.db');
      // deleteDatabase(caminho);
      _db = await openDatabase(
        caminho,
        version: 1,
        onCreate: (db, version) {
          db.execute(_tabelaItem);
          db.execute(_tabelaCarrinho);
          db.execute(_tabelaUsuario);
          db.execute(_insercao1);
          db.execute(_insercao2);
        },
      );
    }
    return _db!;
  }
}
