import 'package:url_launcher/url_launcher.dart';

class AjudaUsuario {
  enviarEmail() {
    launchUrl(
      Uri(
        scheme: 'mailto',
        path: 'suporte@hotmail.com.br',
      ),
    );
  }
}
