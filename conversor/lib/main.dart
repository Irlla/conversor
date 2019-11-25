import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=db8a058a";

void main() async {
 print(await getData());
  runApp(MaterialApp(
    home: Home(),
  ));
}
Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
class Home extends StatefulWidget{
  @override
  _HomeState createState()=> _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: Text("Conversor"),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            return _buildMessage("carregando dados...", Colors.amber);
            default:
            if (snapshot.hasError) {
               return _buildMessage("erro ao carregar dados...", Colors.orange);
            } else {
              return _buildMessage("Dados carregados com sucesso", Colors.white);

            }
        }
        }
      )
    );
  }
  Widget _buildMessage(String text, Color color){
    return Center(
      child: Text(
      text,
      style: TextStyle(color: color, fontSize: 25.0),
      textAlign: TextAlign.center
      ),
    );
  }//buildMessage
}//HomeState
