import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Talento Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _output = "0";
  String _expression = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        _evaluateExpression();
      } else if (value == "C") {
        _expression = "";
        _output = "0";
      } else if (value == "DEL") {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else {
        _expression += value;
      }
    });
  }

  void _evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        _output = result.toString();
      });
    } catch (e) {
      setState(() {
        _output = "Erro!";
      });
    }
  }

  Widget _buildButton(String label, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Ajuste o padding entre os botões
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora Talento Tech"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Visor de resultado
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                _expression,
                style: TextStyle(fontSize: 48, color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _output,
                style: TextStyle(fontSize: 60, color: Colors.black),
              ),
            ),
            // Linhas de botões
            Column(
              children: [
                Row(
                  children: [
                    _buildButton("C", color: Colors.red),
                    _buildButton("DEL", color: Colors.grey),
                    _buildButton("/", color: Colors.orange),
                    _buildButton("*", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("+", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("=", color: Colors.green),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0"),
                    _buildButton(".", color: Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
