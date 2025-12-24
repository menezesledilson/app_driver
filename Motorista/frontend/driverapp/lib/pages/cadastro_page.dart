import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/usuario_service.dart';

class CadastroUsuarioPage extends StatefulWidget {
  const CadastroUsuarioPage({super.key});

  @override
  State<CadastroUsuarioPage> createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final service = UsuarioService();

  final motorista = TextEditingController();
  final placa = TextEditingController();
  final kmSaida = TextEditingController();
  final kmChegada = TextEditingController();
  final destino = TextEditingController();
  final data = TextEditingController();
  final horaSaida = TextEditingController();
  final horaChegada = TextEditingController();
  final obs = TextEditingController();

  bool loading = false;

  void salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      Usuario u = Usuario(
        motorista: motorista.text,
        placa: placa.text,
        kmSaida: kmSaida.text,
        kmChegada: kmChegada.text,
        destino: destino.text,
        data: data.text,
        horaSaida: horaSaida.text,
        horaChegada: horaChegada.text,
        obs: obs.text,
      );

      await service.salvarUsuario(u);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário cadastrado com sucesso!")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Motorista")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              campo("Motorista", motorista),
              campo("Placa", placa),
              campo("KM Saída", kmSaida),
              campo("KM Chegada", kmChegada),
              campo("Destino", destino),
              campo("Data", data),
              campo("Hora Saída", horaSaida),
              campo("Hora Chegada", horaChegada),
              campo("Observação", obs),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: loading ? null : salvar,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campo(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Campo obrigatório" : null,
      ),
    );
  }
}
