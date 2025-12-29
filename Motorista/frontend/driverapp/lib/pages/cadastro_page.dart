import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/usuario.dart';
import '../services/usuario_service.dart';
import '../style/style.dart';
import '../pages/busca_por_data.dart';

class CadastroUsuarioPage extends StatefulWidget {
  const CadastroUsuarioPage({super.key});

  @override
  State<CadastroUsuarioPage> createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final service = UsuarioService();

  final dataMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final horaMask = MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

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

  /// 🔹 Converte dd/MM/yyyy → yyyy-MM-dd
  String converterParaIso(String dataBr) {
    final partes = dataBr.split('/');
    if (partes.length != 3) {
      throw Exception("Data inválida");
    }
    return "${partes[2]}-${partes[1]}-${partes[0]}";
  }

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
        data: converterParaIso(data.text),
        horaSaida: horaSaida.text,
        horaChegada: horaChegada.text,
        obs: obs.text,
      );

      await service.salvarUsuario(u);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro salvo com sucesso!")),
      );

      motorista.clear();
      placa.clear();
      kmSaida.clear();
      kmChegada.clear();
      destino.clear();
      data.clear();
      horaSaida.clear();
      horaChegada.clear();
      obs.clear();

      FocusScope.of(context).requestFocus(FocusNode());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundGrey,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          backgroundColor: AppStyle.primaryBlue,
          title: const Text(
            "Cadastro",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: loading ? null : salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 40),
                ),
                child: Text(
                  loading ? "Salvando..." : "Salvar",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuscarUsuarioPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 40),
                ),
                child: const Text(
                  "Buscar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      children: [
                        SizedBox(width: 400, child: campo("Motorista", motorista)),
                        SizedBox(width: 200, child: campo("Placa", placa)),
                        SizedBox(width: 200, child: campo("KM Saída", kmSaida)),
                        SizedBox(width: 200, child: campo("KM Chegada", kmChegada)),
                        SizedBox(width: 300, child: campo("Destino", destino)),
                        SizedBox(
                          width: 160,
                          child: campo("Data", data, mask: [dataMask]),
                        ),
                        SizedBox(
                          width: 180,
                          child: campo("Hora Saída", horaSaida, mask: [horaMask]),
                        ),
                        SizedBox(
                          width: 180,
                          child: campo("Hora Chegada", horaChegada, mask: [horaMask]),
                        ),
                        SizedBox(
                          width: 500,
                          child: campo("Observação", obs, max: 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget campo(
    String label,
    TextEditingController controller, {
    int max = 1,
    List<TextInputFormatter>? mask,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: max,
      inputFormatters: mask,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ).copyWith(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Campo obrigatório" : null,
    );
  }
}
