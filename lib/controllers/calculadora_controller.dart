class CalculadoraController {
  double calcularLucratividade({required double valor}) {
    double resultado = 0.0;
    if (valor > 0 && valor < 100) resultado = valor + 100;
    if (valor > 99 && valor < 151) resultado = valor + (valor * 1.0);
    if (valor > 150 && valor < 200) resultado = valor + (valor * 0.9);
    if (valor > 199 && valor < 500) resultado = valor + (valor * 0.7);
    if (valor > 499 && valor < 800) resultado = valor + (valor * 0.6);
    if (valor > 799 && valor < 1600) resultado = valor + (valor * 0.5);
    if (valor > 1599) resultado = valor + (valor * 0.4);

    return double.parse((resultado).toStringAsFixed(2));
  }

  double calcularParcelamento6x({required double lucratividade}) {
    return double.parse((lucratividade / 0.91).toStringAsFixed(2));
  }

  double calcularParcelamento12x({required double lucratividade}) {
    return double.parse((lucratividade / 0.87).toStringAsFixed(2));
  }

  double calcularValorParcela({
    required double valor,
    required double numParcelas,
  }) {
    return double.parse((valor / numParcelas).toStringAsFixed(2));
  }
}
