import 'carrinho.dart';

class Item {
  late dynamic id;
  late String nome;
  late String descricao;
  late double quantidade;
  late Carrinho carrinho;

  Item({
    this.id,
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.carrinho,
  });
}
