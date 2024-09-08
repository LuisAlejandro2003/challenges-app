import 'package:flutter/material.dart';
import 'contact.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
		title: const Text('Home'),
		actions: [
		  IconButton(
			icon: const Icon(Icons.contact_page),
			onPressed: () {
			  Navigator.pushNamed(context, '/contact');
			},
		  ),
		  IconButton(
			icon: const Icon(Icons.assignment),
			onPressed: () {
			  Navigator.pushNamed(context, '/reto1');
			},
		  ),
		  IconButton(
			icon: const Icon(Icons.assignment),
			onPressed: () {
			  Navigator.pushNamed(context, '/reto2');
			},
		  ),
		  IconButton(
			icon: const Icon(Icons.assignment),
			onPressed: () {
			  Navigator.pushNamed(context, '/reto3');
			},
		  ),
		],
	  ),
	  body: const Center(
		child: Text('Bienvenido a UP Chiapas'),
	  ),
	);
  }
}