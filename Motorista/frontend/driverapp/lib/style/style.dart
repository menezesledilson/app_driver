import 'package:flutter/material.dart';

class AppStyle {
  /// 🔵 Azul ERP padrão
  static const Color primaryBlue = Color(0xFF0A2A66);

  /// 🔷 Azul botão (igual login)
  static Color buttonBlue = Colors.blue.shade900;

  /// ⚪ Fundo padrão ERP
  static const Color backgroundGrey = Color(0xFFE9ECEF);

  /// 🖤 Texto principal
  //static const Color textDark = Colors.black87;

  static const Color textDark = Colors.white;


  //static const Color backgroundGrey = Color(0xFFF3F4F6);


  /// ❌ Erros
  static const Color error = Colors.red;

  /// 🎨 Estilo padrão para botões ERP
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue.shade900,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 45),
  );

  /// 🎨 AppBar padrão ERP
  static AppBar appBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue.shade900,
      centerTitle: true,
    );
  }
}
