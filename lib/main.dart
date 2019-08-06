import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();  
    });
  }

  void _calculate() {
    final double weight = double.parse(weightController.text);
    final double height = double.parse(heightController.text) / 100;
    final double imc = weight / (height * height);
    print(imc);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso! IMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal! IMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Sobrepeso! IMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obsidade Grau I! IMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obsidade Grau II! IMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infoText = "Obsidade Grau III! IMC: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculador IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    color: Colors.green,
                    size: 120,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Peso (KG)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                    validator: (value) {
                      return value.isEmpty ? "Insira seu peso" : null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                    validator: (value) {
                      return value.isEmpty ? "Insira sua altura" : null;
                       
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                      
                          children: <Widget>[
                            Icon(Icons.aspect_ratio,color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "CALCULAR",
                                style: TextStyle(color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                        fontFamily: 'Roboto'),
                  )
                ],
              ),
            )));
  }
}
