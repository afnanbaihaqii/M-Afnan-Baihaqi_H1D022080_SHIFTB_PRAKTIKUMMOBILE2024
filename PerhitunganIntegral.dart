import 'dart:async';
import 'dart:math';

class IntegralCalculator {
  double Function(double) function;
  IntegralCalculator(this.function);
  double calculate(double a, double b, int n) {
    try {
      if (n <= 0) {
        throw Exception("Nilai n harus lebih besar dari 0.");
      }

      double h = (b - a) / n;
      double sum = 0.0;

      for (int i = 0; i <= n; i++) {
        double x = a + i * h;
        double weight = (i == 0 || i == n) ? 1 : 2;
        sum += weight * function(x);
      }

      return (h / 2) * sum;
    } catch (e) {
      print("Terjadi kesalahan: ${e.toString()}");
      return 0.0;
    }
  }

  Future<double> calculateAsync(double a, double b, int n) async {
    return await Future.delayed(Duration(seconds: 2), () {
      return calculate(a, b, n);
    });
  }
}

void main() async {
  double function(double x) {
    return pow(x, 2).toDouble();
  }

  var calculator = IntegralCalculator(function);

  double a = 0;
  double b = 1;
  int n = 1000;

  print("Menghitung integral secara async...");
  double result = await calculator.calculateAsync(a, b, n);
  print("Hasil integral: $result");

  if (result > 0) {
    print("Perhitungan berhasil!");
  } else {
    print("Perhitungan gagal.");
  }
}
