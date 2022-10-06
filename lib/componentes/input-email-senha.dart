import 'package:flutter/material.dart';

import 'ajuda-usuario.dart';

class InputEmailSenha extends StatefulWidget {
  const InputEmailSenha({Key? key}) : super(key: key);

  @override
  State<InputEmailSenha> createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<InputEmailSenha> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String senha = '';
  bool _esconderSenha = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
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
            padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _esconderSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    setState(
                      () {
                        _esconderSenha = !_esconderSenha;
                      },
                    );
                  },
                ),
              ),
              obscureText: _esconderSenha,
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
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _fazerLogin(email: email, senha: senha);
                    }
                  },
                  child: const Text('Efetuar Login'),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  const Text(
                    "Precisa de ajuda?",
                    style: TextStyle(
                      fontSize: 10.3,
                    ),
                  ),
                  IconButton(
                    onPressed: () => AjudaUsuario().enviarEmail(),
                    icon: const Icon(
                      Icons.email,
                      color: Color(0xFF6562DF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _fazerLogin({required String email, required String senha}) {}
