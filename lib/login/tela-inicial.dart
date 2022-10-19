import 'package:flutter/material.dart';
import 'package:lista_compras/login/cadastro.dart';

import 'login.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.purple,
                Colors.blueAccent,
              ],
              stops: [
                0.4,
                0.7,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 160,
                  backgroundImage: AssetImage('lib/images/shopping-list.jpg'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaLogin(),
                        ),
                      );
                    },
                    child: const Text('Efetuar Login'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaCadastro(),
                      ),
                    );
                  },
                  child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
