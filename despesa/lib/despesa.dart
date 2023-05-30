class Despesa {
  late int? id;
  late String tipo;
  late double valor;

  Despesa({required this.id, required this.tipo, required this.valor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'valor': valor,
    };
  }

  factory Despesa.fromMap(Map<String, dynamic> map) {
    return Despesa(
      id: map['id'],
      tipo: map['tipo'],
      valor: map['valor'],
    );
  }
}