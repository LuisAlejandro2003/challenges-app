import 'package:flutter/material.dart';

class Reto1Screen extends StatelessWidget {
  const Reto1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
		title: const Text('Reto 1'),
	  ),
	  body: const Center(
		child: Text('Contenido del Reto 1'),
	  ),
	);
  }
}