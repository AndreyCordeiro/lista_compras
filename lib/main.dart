import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_compras/login/login.dart';

import 'efeitos/page-transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomTransitionBuilder(),
            TargetPlatform.iOS: CustomTransitionBuilder(),
            TargetPlatform.macOS: CustomTransitionBuilder(),
            TargetPlatform.windows: CustomTransitionBuilder(),
            TargetPlatform.linux: CustomTransitionBuilder(),
          },
        ),
        primarySwatch: Colors.blue,
      ),
      home: const TelaLogin(),
    );
  }
}
