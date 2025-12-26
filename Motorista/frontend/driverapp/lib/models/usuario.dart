class Usuario {
  final int? id;
  final String motorista;
  final String placa;
  final String kmSaida;
  final String kmChegada;
  final String destino;
  final String data; // yyyy-MM-dd
  final String horaSaida;
  final String horaChegada;
  final String obs;

  Usuario({
    this.id,
    required this.motorista,
    required this.placa,
    required this.kmSaida,
    required this.kmChegada,
    required this.destino,
    required this.data,
    required this.horaSaida,
    required this.horaChegada,
    required this.obs,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      motorista: json['motorista'],
      placa: json['placa'],
      kmSaida: json['kmSaida'],
      kmChegada: json['kmChegada'],
      destino: json['destino'],
      data: json['data'],
      horaSaida: json['horaSaida'],
      horaChegada: json['horaChegada'],
      obs: json['obs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "motorista": motorista,
      "placa": placa,
      "kmSaida": kmSaida,
      "kmChegada": kmChegada,
      "destino": destino,
      "data": data,
      "horaSaida": horaSaida,
      "horaChegada": horaChegada,
      "obs": obs,
    };
  }
}
