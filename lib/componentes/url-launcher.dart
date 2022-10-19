import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  enviarEmail() {
    launchUrl(
      Uri(
        scheme: 'mailto',
        path: 'suporte@hotmail.com.br',
      ),
    );
  }

  enviarMensagem() {
    launchUrl(
      Uri(
        scheme: 'sms',
        path: '(44) 9 9999-9999',
      ),
    );
  }
}
