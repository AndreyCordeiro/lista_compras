final criarBanco = [
  '''
       CREATE TABLE item (
      id_item INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      quantidade TEXT NOT NULL,
      carrinho_id INTEGER NOT NULL,
      FOREIGN KEY(carrinho_id) REFERENCES carrinho(id_carrinho)
      )
  ''',
  '''CREATE TABLE carrinho (
          id_carrinho INTEGER NOT NULL PRIMARY KEY,
          nome TEXT NOT NULL
      )'''
];
