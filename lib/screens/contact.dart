import 'package:flutter/material.dart';

void main() => runApp(const ContactApp());

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
	return const MaterialApp(
	  home: ContactScreen(),
	);
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _names = [];
  final List<String> _predefinedNames = [
	'221245 Darío Antonio Gutiérrez Álvarez',
	'213021 Luis Alejandro Martinez Montoya'
  ];
  bool _showNames = true;
  int _clickCount = 0;

  void _toggleNames() {
	setState(() {
	  _clickCount++;
	  if (_clickCount == 3) {
		_showAlert();
		_clickCount = 0; // Reset the counter after showing the alert
	  } else {
		if (_showNames) {
		  for (int i = _names.length - 1; i >= 0; i--) {
			_listKey.currentState?.removeItem(
			  i,
			  (context, animation) => _buildItem(_names[i], animation),
			  duration: const Duration(milliseconds: 500),
			);
		  }
		  _names.clear();
		} else {
		  for (int i = 0; i < _predefinedNames.length; i++) {
			_names.add(_predefinedNames[i]);
			_listKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 500));
		  }
		}
		_showNames = !_showNames;
	  }
	});
  }

  void _showAlert() {
	showDialog(
	  context: context,
	  builder: (BuildContext context) {
		return AlertDialog(
		  title: const Text('Alerta'),
		  content: const Text('Ya son todos los integrantes.'),
		  actions: <Widget>[
			TextButton(
			  child: const Text('OK'),
			  onPressed: () {
				Navigator.of(context).pop();
			  },
			),
		  ],
		);
	  },
	);
  }

  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
		title: const Text('Contactos'),
	  ),
	  body: AnimatedList(
		key: _listKey,
		initialItemCount: _names.length,
		itemBuilder: (context, index, animation) {
		  return _buildItem(_names[index], animation);
		},
	  ),
	  floatingActionButton: FloatingActionButton(
		onPressed: _toggleNames,
		tooltip: 'Toggle Contactos',
		child: const Icon(Icons.add),
	  ),
	);
  }

  Widget _buildItem(String name, Animation<double> animation) {
	return FadeTransition(
	  opacity: animation,
	  child: ListTile(
		title: Text(name),
	  ),
	);
  }
}