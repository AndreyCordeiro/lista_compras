import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/url-launcher.dart';

class AjudaUsuario extends StatelessWidget {
  const AjudaUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Entre em contato",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              IconButton(
                onPressed: () => UrlLauncher().enviarEmail(),
                icon: const Icon(
                  Icons.email,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
