import 'package:calculadora/enums/operation_type.dart';
import 'package:calculadora/pages/historic_page.dart';
import 'package:calculadora/widgets/buttom_widgets.dart';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  late String displaynumber;
  @override
  void initState() {
    displaynumber = '0';
    //historic = [];
    super.initState();
  }

  void setOperationType(OperationTypeEnum newType) {
    setState(() {
      displaynumber += newType.symbol;
    });
  }

  void clearCalculator() {
    setState(() {
      displaynumber = "0";
    });
  }

  void appendNumber(String stringNumber) {
    setState(() {
      if (displaynumber == "0") {
        displaynumber = stringNumber;
      } else {
        displaynumber += stringNumber;
      }
    });
  }

  void removeNumber() {
    setState(() {
      if (displaynumber.length <= 1) {
        displaynumber = "0";
      } else {
        displaynumber = displaynumber.substring(0, displaynumber.length - 1);
      }
    });
  }

  List<double> parseNumber(String expression) {
    RegExp regExp = RegExp(r'[0-9]+\.?[0-9]*');

    var matches = regExp.allMatches(expression);

    List<double> numbers = [];

    for (var match in matches) {
      String numberText = match.group(0)!;

      numbers.add(double.parse(numberText));
    }
    return numbers;
  }

  List<OperationTypeEnum> getOperator(String expression) {
    final expression1 = expression.characters.where(
      (x) => OperationTypeEnum.values.any((op) => op.symbol == x),
    );

    return expression1
        .map((x) => OperationTypeEnum.values.firstWhere((op) => op.symbol == x))
        .toList();
  }

  void calculate() {
    String expression = displaynumber.replaceAll('.', '.');
    List<double> numbers = parseNumber(expression);
    List<OperationTypeEnum> operations = getOperator(expression);

    resolvePriorityOperations(numbers, operations);
    final result = resolveAdditionAndSubtraction(numbers, operations);

    setState(() {
      displaynumber = result.toString().replaceAll('.', ',');
    });
  }

  void resolvePriorityOperations(
    List<double> numbers,
    List<OperationTypeEnum> operators,
  ) {
    int index = 0;

    while (index < operators.length) {
      if (operators[index] == OperationTypeEnum.multiplication) {
        numbers[index] = numbers[index] * numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      } else if (operators[index] == OperationTypeEnum.division) {
        numbers[index] = numbers[index] / numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      } else {
        index++;
      }
    }
  }

  double resolveAdditionAndSubtraction(
    List<double> numbers,
    List<OperationTypeEnum> operators,
  ) {
    int index = 0;

    while (index < operators.length) {
      if (operators[index] == OperationTypeEnum.addition) {
        numbers[index] = numbers[index] + numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      } else if (operators[index] == OperationTypeEnum.subtraction) {
        numbers[index] = numbers[index] - numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      }
    }
    return numbers[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        actions: [
          // IconButton(
          //   onPressed: (){Navigator.push(context, MaterialPageRoute(builder: ()=>HistoricPage(historic: historic));
          // );};
          // icon: Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.black12,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                displaynumber,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  ButtomWidgets(
                    text: "C",
                    onPressed: () {
                      clearCalculator();
                    },
                    color: Colors.red,
                  ),
                  ButtomWidgets(
                    text: "⌫",
                    onPressed: () {
                      removeNumber();
                    },
                    color: Colors.orangeAccent,
                  ),
                  ButtomWidgets(
                    text: "÷",
                    onPressed: () {
                      setOperationType(OperationTypeEnum.division);
                    },
                    color: Colors.blue,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtomWidgets(
                    text: "7",
                    onPressed: () {
                      appendNumber('7');
                    },
                  ),
                  ButtomWidgets(
                    text: "8",
                    onPressed: () {
                      appendNumber('8');
                    },
                  ),
                  ButtomWidgets(
                    text: "9",
                    onPressed: () {
                      appendNumber('9');
                    },
                  ),
                  ButtomWidgets(
                    text: "X",
                    onPressed: () {
                      setOperationType(OperationTypeEnum.multiplication);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtomWidgets(
                    text: "4",
                    onPressed: () {
                      appendNumber('4');
                    },
                  ),
                  ButtomWidgets(
                    text: "5",
                    onPressed: () {
                      appendNumber('5');
                    },
                  ),
                  ButtomWidgets(
                    text: "6",
                    onPressed: () {
                      appendNumber('6');
                    },
                  ),
                  ButtomWidgets(
                    text: "-",
                    onPressed: () {
                      setOperationType(OperationTypeEnum.subtraction);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtomWidgets(
                    text: "1",
                    onPressed: () {
                      appendNumber('1');
                    },
                  ),
                  ButtomWidgets(
                    text: "2",
                    onPressed: () {
                      appendNumber('2');
                    },
                  ),
                  ButtomWidgets(
                    text: "3",
                    onPressed: () {
                      appendNumber('3');
                    },
                  ),
                  ButtomWidgets(
                    text: "+",
                    onPressed: () {
                      setOperationType(OperationTypeEnum.addition);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtomWidgets(
                    text: "0",
                    onPressed: () {
                      appendNumber('0');
                    },
                  ),
                  ButtomWidgets(
                    text: ",",
                    onPressed: () {
                      appendNumber(',');
                    },
                  ),
                  ButtomWidgets(
                    text: "=",
                    onPressed: () {
                      calculate();
                    },
                    color: Colors.green,
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
