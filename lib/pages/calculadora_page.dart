import 'package:calculadora/enums/operation_type.dart';
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
    super.initState();
  }

  void setOperationType(OperationTypeEnum newType) {
    setState(() {
      displaynumber += newType.symbol;
    });
  }
  void clearCalculator(){
    setState(() {
      displaynumber = "0";
    });
  }
  void appendNumber(String stringNumber){
    setState(() {
      if(displaynumber == "0"){
        displaynumber = stringNumber;
      }else{
        displaynumber += stringNumber;
      }
    });
  }
  void removeNumber(){
    setState(() {
      if(displaynumber.length <=1){
        displaynumber = "0";
      }else{
        displaynumber = displaynumber.substring(0,displaynumber.length-1);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
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
                  ButtomWidgets(text: "C", onPressed: () {clearCalculator();}, color: Colors.red),
                  ButtomWidgets(
                    text: "⌫",
                    onPressed: () {removeNumber();},
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
                  ButtomWidgets(text: "7", onPressed: () {appendNumber('7');}),
                  ButtomWidgets(text: "8", onPressed: () {appendNumber('8');}),
                  ButtomWidgets(text: "9", onPressed: () {appendNumber('9');}),
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
                  ButtomWidgets(text: "4", onPressed: () {appendNumber('4');}),
                  ButtomWidgets(text: "5", onPressed: () {appendNumber('5');}),
                  ButtomWidgets(text: "6", onPressed: () {appendNumber('6');}),
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
                  ButtomWidgets(text: "1", onPressed: () {appendNumber('1');}),
                  ButtomWidgets(text: "2", onPressed: () {appendNumber('2');}),
                  ButtomWidgets(text: "3", onPressed: () {appendNumber('3');}),
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
                  ButtomWidgets(text: "0", onPressed: () {appendNumber('0');}),
                  ButtomWidgets(text: ",", onPressed: () {appendNumber(',');}),
                  ButtomWidgets(
                    text: "=",
                    onPressed: () {},
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
