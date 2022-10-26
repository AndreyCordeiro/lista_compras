import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static Database? _conexao;
  static const String _criarTabelaItem = '''
          CREATE TABLE item (
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          descricao TEXT NOT NULL,
          quantidade TEXT NOT NULL)
  ''';

  static const String _criarTabelaUsuario = '''
          CREATE TABLE usuario (
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          email TEXT NOT NULL,
          senha TEXT NOT NULL)
  ''';

  static const String _insercao1 =
      'INSERT INTO item (nome, descricao, quantidade) VALUES ("Miojo", "macarrão instantâneo", "4")';

  static const String _insercao2 =
      'INSERT INTO item (nome, descricao, quantidade) VALUES ("Macarrão", "Macarrão pacote", "2")';

  static const String _insercao3 =
      'INSERT INTO usuario (nome, email, senha) VALUES ("Andrey", "andreybr2002@hotmail.com", "12345")';

  static const String _insercao4 =
      'INSERT INTO usuario (nome, email, senha) VALUES ("Andrey Cordeiro", "andrey.nextage@gmail.com", "678910")';

  static Future<Database> abrir() async {
    if (_conexao == null) {
      String path = join(await getDatabasesPath(), 'shopping_list');
      deleteDatabase(path);
      _conexao = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(_criarTabelaItem);
          db.execute(_criarTabelaUsuario);
          db.execute(_insercao1);
          db.execute(_insercao2);
          db.execute(_insercao3);
          db.execute(_insercao4);
        },
      );
    }
    return _conexao!;
  }
}
