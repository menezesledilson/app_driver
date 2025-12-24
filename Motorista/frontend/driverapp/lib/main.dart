import 'package:flutter/material.dart';
import 'pages/cadastro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motorista App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motorista - Controle')),
      body: const Center(
        child: Text('Bem-vindo!', style: TextStyle(fontSize: 18)),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Novo Cadastro',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CadastroUsuarioPage(), // <- aqui!
            ),
          );
        },
      ),
    );
  }
}
