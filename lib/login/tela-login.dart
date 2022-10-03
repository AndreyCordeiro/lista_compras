import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginWidget();
}

class _TelaLoginWidget extends State<TelaLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Tarefa"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o E-mail!';
                  }
                  email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Senha',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a Senha!';
                  }
                  senha = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _fazerLogin(email: email, senha: senha);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                onPressed: () => enviarEmail(),
                icon: const Icon(
                  Icons.email,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _fazerLogin({required String email, required String senha}) {}

enviarEmail() {
  launchUrl(
    Uri(
      scheme: 'mailto',
      path: 'listaCompras@hotmail.com.br',
    ),
  );
}
