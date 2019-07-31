import 'package:flutter/material.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de contatos'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
