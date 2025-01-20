import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Importando a biblioteca

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
  String _output = "0"; // Resultado da expressão
  String _expression = ""; // Expressão sendo digitada

  // Função que processa os botões
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        // Avaliar a expressão matemática
        _evaluateExpression();
      } else if (value == "C") {
        // Limpar a expressão
        _expression = "";
        _output = "0";
      } else if (value == "DEL") {
        // Apagar o último caractere
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
      // Criar um analisador para a expressão
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      
      // Avaliar a expressão e obter o resultado
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

  // Função para gerar os botões
  Widget _buildButton(String label, {Color color = Colors.grey}) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Cor do botão
        fixedSize: Size(80, 80), // Tamanho fixo do botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // Botões arredondados
        ),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 32, color: Colors.white),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("C", color: Colors.red), // Limpar
                    _buildButton("DEL", color: Colors.grey), // Apagar
                    _buildButton("/", color: Colors.orange), // Divisão
                    _buildButton("*", color: Colors.orange), // Multiplicação
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("-", color: Colors.orange), // Subtração
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("+", color: Colors.orange), // Soma
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("=", color: Colors.green), // Resultado
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("0"),
                    _buildButton(".", color: Colors.grey), // Ponto
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
