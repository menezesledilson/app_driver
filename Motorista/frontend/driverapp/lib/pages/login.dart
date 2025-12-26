import 'package:flutter/material.dart';
import './cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  String? error;

  void login() {
    if (userController.text.trim() == 'admin' &&
        passController.text.trim() == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CadastroUsuarioPage()),
      );
    } else {
      setState(() {
        error = 'Usuário ou senha inválidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9ECEF),

      appBar: AppBar(
       // title: const Text('Sistema Motorista - Acesso'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),

      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),

              if (error != null) ...[
                const SizedBox(height: 10),
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  onPressed: login,
                  child: const Text(
                    'Entrar no Sistema',
                    style: TextStyle(fontSize: 16,
                    color: Colors.white,
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//flutter run -d chrome --web-port=5000