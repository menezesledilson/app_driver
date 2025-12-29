import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/usuario.dart';
import '../services/usuario_service.dart';
import '../style/style.dart';

class BuscarUsuarioPage extends StatefulWidget {
  const BuscarUsuarioPage({super.key});

  @override
  State<BuscarUsuarioPage> createState() => _BuscarUsuarioPageState();
}

class _BuscarUsuarioPageState extends State<BuscarUsuarioPage> {
  final service = UsuarioService();

  DateTime? dataInicial;
  DateTime? dataFinal;

  bool loading = false;
  bool buscou = false;

  List<Usuario> resultados = [];

  // 🔹 formatos
  final displayFormat = DateFormat('dd/MM/yyyy');
  final backendFormat = DateFormat('yyyy-MM-dd');

  void buscar() async {
    if (dataInicial == null || dataFinal == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Selecione as duas datas.")));
      return;
    }

    if (dataFinal!.isBefore(dataInicial!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("A data final não pode ser menor que a inicial."),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
      buscou = true;
    });

    try {
      final usuarios = await service.buscarPorData(
        backendFormat.format(dataInicial!), // ✅ ISO
        backendFormat.format(dataFinal!), // ✅ ISO
      );

      setState(() => resultados = usuarios);

      if (usuarios.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nenhum registro encontrado.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }

    setState(() => loading = false);
  }

  Future<void> pickDateInicial() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dataInicial ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _dateTheme,
    );
    if (picked != null) setState(() => dataInicial = picked);
  }

  Future<void> pickDateFinal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dataFinal ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _dateTheme,
    );
    if (picked != null) setState(() => dataFinal = picked);
  }

  Theme _dateTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: AppStyle.primaryBlue,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      child: child!,
    );
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
            "Buscar por Data",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _botaoData(
                          label: "Data Inicial",
                          data: dataInicial,
                          onPressed: pickDateInicial,
                        ),
                        _botaoData(
                          label: "Data Final",
                          data: dataFinal,
                          onPressed: pickDateFinal,
                        ),
                        ElevatedButton(
                          onPressed: loading ? null : buscar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(120, 50),
                          ),
                          child: Text(
                            loading ? "Buscando..." : "Buscar",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// RESULTADO
                    Expanded(
                      child: !buscou
                          ? const Center(child: Text("Selecione um período"))
                          : resultados.isEmpty
                          ? const Center(
                              child: Text("Nenhum registro encontrado"),
                            )
                          : ListView.builder(
                              itemCount: resultados.length,
                              itemBuilder: (context, index) {
                                final u = resultados[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          u.motorista,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 4,
                                          children: [
                                            Text(
                                              "Data: ${DateFormat('dd/MM/yyyy')
                                              .format(DateTime.parse(u.data),
                                              )}",
                                            ),
                                            Text("Placa: ${u.placa}"),
                                            Text("Km Saída: ${u.kmSaida}"),
                                            Text("Km Chegada: ${u.kmChegada}"),
                                            Text("Destino: ${u.destino}"),
                                            Text("Saída: ${u.horaSaida}"),
                                            Text("Chegada: ${u.horaChegada}"),
                                            Text("Obs: ${u.obs}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botaoData({
    required String label,
    required DateTime? data,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        minimumSize: const Size(240, 50),
      ),
      child: Text(
        data == null ? label : "$label: ${displayFormat.format(data)}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
