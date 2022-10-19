import 'package:flutter/material.dart';

import 'ajuda-usuario.dart';

class InputNomeEmailSenha extends StatefulWidget {
  const InputNomeEmailSenha({Key? key}) : super(key: key);

  @override
  State<InputNomeEmailSenha> createState() => _InputNomeEmailSenhaState();
}

class _InputNomeEmailSenhaState extends State<InputNomeEmailSenha> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome = '';
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
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Nome',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o Nome!';
                }
                nome = value;
              },
            ),
          ),
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
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _efetuarCadastro(email: email, senha: senha);
                    }
                  },
                  child: const Text('Criar Conta'),
                ),
              ),
            ),
          ),
          const AjudaUsuario(),
        ],
      ),
    );
  }
}

void _efetuarCadastro({required String email, required String senha}) {}
