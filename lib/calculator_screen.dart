import 'package:flutter/material.dart';
import 'calculator_button.dart'; 

// Định nghĩa màu sắc khớp với hình ảnh
const Color screenBackgroundColor = Color(0xFF2D3142); 
const Color numberButtonColor = Color(0xFF2E3131); 
const Color clearButtonColor = Color(0xFFC05555);
const Color operatorButtonColor = Color(0xFF4C7B4C); 
const Color specialButtonColor = Color(0xFF4C4F4F); 

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; 
  String _equation = ""; 
  double _num1 = 0; 
  double _num2 = 0; 
  String _operation = ""; 

  String _formatNumber(double num) {
    String numStr = num.toString();
    if (numStr.endsWith(".0")) {
      return numStr.substring(0, numStr.length - 2);
    }
    return numStr;
  }

  void _handleEquals() {
    if (_operation.isEmpty || _operation == "=") {
      _equation = _output;
      _operation = "="; 
      return;
    }

    _num2 = double.tryParse(_output) ?? 0;
    double result = 0;
    String currentEquation = "${_formatNumber(_num1)} $_operation ${_formatNumber(_num2)} =";

    try {
      if (_operation == '+') result = _num1 + _num2;
      else if (_operation == '-') result = _num1 - _num2;
      else if (_operation == 'x') result = _num1 * _num2;
      else if (_operation == '÷') {
        if (_num2 == 0) {
          _output = "Error";
          _operation = "";
          _num1 = 0;
          _equation = currentEquation;
          return;
        }
        result = _num1 / _num2;
      }
      
      String resultString = _formatNumber(result);

      _output = resultString;
      _equation = currentEquation;
      _num1 = result;
      _operation = "="; 
    } catch (e) {
      _output = "Error";
      _operation = "";
    }
  }

  void handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') { 
        _output = '0';
        _equation = '';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
      } else if (buttonText == '( )') {
        return;
      } // CE: Xóa giá trị đầu ra, giữ nguyên phép toán và phương trình (thay cho ± từ bản gốc)
      else if (buttonText == 'CE') { 
        _output = '0';
      } else if (buttonText == '%') { 
        double currentValue = double.tryParse(_output) ?? 0;
        _output = (currentValue / 100).toString();
      } 

      else if (['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'].contains(buttonText)) {
        if (_output == 'Error') {
            _output = '0'; 
        }
        
        if (_operation == "=") {
          _output = (buttonText == '.') ? '0.' : buttonText;
          _equation = "";
          _operation = "";
        }
        else if (buttonText == '.' && _output.contains('.')) {
          return; 
        } else if (_output == '0' && buttonText != '.') {
          _output = buttonText;
        } else {
          _output += buttonText; 
        }
      }

      else if (['+', '-', 'x', '÷'].contains(buttonText)) {
        if (_operation.isNotEmpty && _operation != "=") {
          _handleEquals();
        }
        
        _num1 = double.tryParse(_output) ?? 0; 
        _operation = buttonText; 
        _equation = "${_formatNumber(_num1)} $_operation";
        _output = "0"; 
      }

      else if (buttonText == '=') { 
        _handleEquals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[

            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _equation,
                      style: const TextStyle(
                        fontSize: 24.0, 
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _output,
                      style: const TextStyle(
                        fontSize: 50.0, 
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Color(0xFF4F5D75)),
            const SizedBox(height: 16.0),
            Expanded(
              flex: 2, 
              child: Column(
                children: _buildButtonGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtonGrid() {
    final List<List<String>> buttonRows = [
      ['C', '( )', '%', '÷'], 
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['CE', '0', '.', '='],
    ];

    return buttonRows.map((row) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: row.map((buttonText) {
            
            bool isOperator = ['÷', 'x', '-', '+', '='].contains(buttonText);
            bool isClear = (buttonText == 'C');
            bool isSpecial = ['( )', '%', 'CE'].contains(buttonText);
            
            Color buttonColor = numberButtonColor; 
            double size = 24.0; 

            if (isClear) {
              buttonColor = clearButtonColor; 
            } else if (isOperator) {
              buttonColor = operatorButtonColor; 
              size = 30.0;
            } else if (isSpecial) {
              buttonColor = specialButtonColor;
            }

            return CalculatorButton(
              text: buttonText,
              fillColor: buttonColor,
              textColor: Colors.white,
              textSize: size, 
              callback: handleButtonPress,
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
