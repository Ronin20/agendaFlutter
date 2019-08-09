import 'dart:io';

import 'package:agenda/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  final Contact contact;
  ContatoPage({this.contact});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  Contact _editedContact;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_editedContact.name ?? 'Novo contato'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.save),
          onPressed: () {
            if (_editedContact.name != null && _editedContact.name.isNotEmpty) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editedContact.img != null
                              ? FileImage(File(_editedContact.img))
                              : AssetImage('images/person.png'))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.orange)),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.orange)),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContact.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: 'Telefone',
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.orange)),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContact.phone = text;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ));
  }
}
