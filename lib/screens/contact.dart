import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  final List<String> names;

  const ContactScreen({Key? key, required this.names}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(names[index]),
          );
        },
      ),
    );
  }
}