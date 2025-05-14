import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _resultado = '0';
  String _expresion = '0';

  void _presionar(String valor) {
    setState(() {
      if (valor == 'c') {
        _expresion = '0';
        _resultado = '0';
      } else if (valor == '=') {
        try {
          _resultado = _evaluarExpresion(_expresion);
        } catch (e) {
          _resultado = 'Error';
        }
      } else {
        if (_expresion == '0') {
          _expresion = valor;
        } else {
          _expresion += valor; 
        }
      }
    });
  }

  String _evaluarExpresion(String expr) {
    double resultado;
    if (expr.contains('+')) {
      var partes = expr.split('+');
      resultado = double.parse(partes[0]) + double.parse(partes[1]);
    } else if (expr.contains('-')) {
      var partes = expr.split('-');
      resultado = double.parse(partes[0]) - double.parse(partes[1]);
    } else if (expr.contains('*')) {
      var partes = expr.split('*');
      resultado = double.parse(partes[0]) * double.parse(partes[1]);
    } else if (expr.contains('/')) {
      var partes = expr.split('/');
      resultado = double.parse(partes[0]) / double.parse(partes[1]);
    } else {
      resultado = double.parse(expr);
    }
    return resultado.toString();
  }

  Widget _boton(String texto) {
    Color fondo = Colors.blueGrey;
    Color textoColor = Colors.white;

    // Cambiar estilo según el tipo de botón
    if (texto == 'c') {
      fondo = Colors.red;
    } else if (texto == '=') {
      fondo = Colors.green;
    } else if ('/*-+'.contains(texto)) {
      fondo = Colors.orange;
    }

    return ElevatedButton(
      onPressed: () => _presionar(texto),
      child: Text(
        texto,
        style: TextStyle(fontSize: 24, color: textoColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: fondo,
        minimumSize: const Size(80, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de imagen (comentado hasta que agregues el asset)
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/fondo.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _expresion,
                        style: const TextStyle(fontSize: 32, color: Colors.black),
                      ),
                      Text(
                        _resultado,
                        style: const TextStyle(
                            fontSize: 48,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_boton('7'), _boton('8'), _boton('9'), _boton('/')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_boton('4'), _boton('5'), _boton('6'), _boton('*')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_boton('1'), _boton('2'), _boton('3'), _boton('-')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_boton('0'), _boton('c'), _boton('='), _boton('+')],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}