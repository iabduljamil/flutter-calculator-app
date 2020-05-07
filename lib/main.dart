

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Calculator(),
      title: "Simple Calculator App",
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(title: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator>
{
  String data="0";
  String result="0";
  String expression="";
  double fontSize=25;
  double resultFontSize=35;

  onPress(String buttonText)
  {
    setState(() {
      if(buttonText=="C")
      {
      data="0";result="0";
      }
      else if(buttonText == "⌫")
      {
        data=data.substring(0,data.length-1);
        if(buttonText=="0")
        data="0";

      }
      else if(buttonText=="=")
      {
        data=data;
        expression=data;
        
        try {
          Parser some=Parser();
          Expression exp= some.parse(expression);
          ContextModel cm= ContextModel();
          result='${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result="Error";
        }
      }
      else if(data=="0")
      data=buttonText;
      else
      data=data+buttonText;
    });
  }


  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => onPress(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title:Text("Calculator"),centerTitle: true,),
      body: Column(
        children:[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(data,style: TextStyle(fontSize: 28),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(child: Divider(),),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children:[
                    TableRow(children: [
                      buildButton("C", 1, Colors.red[300]),
                      buildButton("⌫", 1,Colors.red[300]),
                      buildButton("÷", 1,Colors.red[200]),
                    ]),

                    TableRow(children: [
                      buildButton("1",1,Colors.grey),
                      buildButton("2",1,Colors.grey),
                      buildButton("3",1,Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.grey),
                      buildButton("5", 1, Colors.grey),
                      buildButton("6", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.grey),
                      buildButton("8", 1, Colors.grey),
                      buildButton("9", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.red[300]),
                      buildButton("0", 1,Colors.grey),
                      buildButton("00", 1, Colors.grey),
                    ]),
                  ]
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*.25,
                child: Column(
                  children:[
                    Table(children: [
                      TableRow(
                        children:[buildButton("x",1,Colors.red[500]),]
                      ),
                      TableRow(
                        children:[buildButton("+",1,Colors.red[500]),]
                      ),
                      TableRow(
                        children:[buildButton("-",1,Colors.red[500]),]
                      ),
                      TableRow(
                        children:[buildButton("=",2,Colors.red[600]),]
                      )
                    ],)
                
                  ]
                ),
              ),

            ] ,
            ),

        ],
      ),
    );
  }
}