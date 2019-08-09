import 'dart:io';

import 'package:agenda/helpers/contact_helper.dart';
import 'package:agenda/pages/contact_page.dart';
import 'package:flutter/material.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  ContactHelper helper = ContactHelper();
  List<Contact> contatos = List();

  @override
  void initState() {
    super.initState();

    /*Contact c = Contact();
    c.name = 'Ronin';
    c.email = 'roninsoaresflu129@gmail.com';
    c.phone = '996942833';
    helper.saveContact(c);
    */
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contatos'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: _showContactPage,
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contatos.length,
          itemBuilder: (contex, index) {
            return _contactCard(context, index);
          },
        ));
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _showContactPage(contact: contatos[index]);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contatos[index].img != null
                            ? FileImage(File(contatos[index].img))
                            : AssetImage('images/person.png'))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contatos[index].name ?? '',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contatos[index].email ?? '',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contatos[index].phone ?? '',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContatoPage(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }
}
