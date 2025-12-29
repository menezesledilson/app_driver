import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:driverapp/pages/cadastro_page.dart';
import './pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motorista',

      // 🔹 FORÇA PORTUGUÊS BRASIL
      locale: const Locale('pt', 'BR'),

      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      //home: const LoginPage(),
      home: const CadastroUsuarioPage(),
    );
  }
}
