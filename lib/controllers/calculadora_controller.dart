class CalculadoraController {
  double calcularLucratividade({required double valor}) {
    if (valor > 0 && valor < 100) return valor + 100;
    if (valor > 99 && valor < 200) return valor + (valor * 1.2);
    if (valor > 199 && valor < 500) return valor + (valor * 0.7);
    if (valor > 499 && valor < 800) return valor + (valor * 0.6);
    if (valor > 799 && valor < 1600) return valor + (valor * 0.5);
    if (valor > 1599) return valor + (valor * 0.4);
    return 0.0;
  }

  double calcularParcelamento6x({required double lucratividade}) {
    return lucratividade / 0.91;
  }

  double calcularParcelamento12x({required double lucratividade}) {
    return lucratividade / 0.87;
  }
}
