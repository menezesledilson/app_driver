import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = "http://localhost:8080/usuario";


  /// CREATE
  Future<Usuario> salvarUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao salvar usuário: ${response.statusCode}");
    }
  }

  /// READ - LISTAR TODOS
  Future<List<Usuario>> listarUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Usuario.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar usuários");
    }
  }

  /// READ - BUSCAR POR ID
  Future<Usuario> buscarPorId(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Usuário não encontrado");
    }
  }

  /// UPDATE
  Future<Usuario> atualizarUsuario(Usuario usuario) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${usuario.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao atualizar usuário");
    }
  }

  /// DELETE
  Future<void> deletarUsuario(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Erro ao deletar usuário");
    }
  }

 Future<List<Usuario>> buscarPorData(
  String dataInicialIso,
  String dataFinalIso,
) async {
  final uri = Uri.http(
    "localhost:8080",
    "/usuario/buscar-por-data",
    {
      "dataInicial": dataInicialIso, // Já está no formato yyyy-MM-dd
      "dataFinal": dataFinalIso,     // Já está no formato yyyy-MM-dd
    },
  );


  final response = await http.get(uri);

  //print("📥 Resposta: ${response.statusCode} - ${response.body}");

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((e) => Usuario.fromJson(e)).toList();
  } else if (response.statusCode == 404) {
    // Se não encontrar registros, retorna lista vazia
    return [];
  } else {
    throw Exception("Erro ${response.statusCode}: ${response.body}");
  }
}

}
