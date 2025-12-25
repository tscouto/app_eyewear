class FreteSimuladoService {
  /// Retorna opções de frete SEM API (simulado)
  static Future<List<Map<String, dynamic>>> calcularFrete({
    required String cepOrigem,
    required String cepDestino,
    double peso = 1,
  }) async {
    // Simula tempo de resposta de API
    await Future.delayed(const Duration(milliseconds: 800));

    final List<Map<String, dynamic>> lista = [];

    // Motoboy (local)
    lista.add({
      'nome': 'Motoboy',
      'valor': 15.00,
      'prazo': 1,
    });

    // PAC
    lista.add({
      'nome': 'PAC',
      'valor': 27.90,
      'prazo': 6,
    });

    // SEDEX
    lista.add({
      'nome': 'SEDEX',
      'valor': 49.90,
      'prazo': 2,
    });

    return lista;
  }
}
