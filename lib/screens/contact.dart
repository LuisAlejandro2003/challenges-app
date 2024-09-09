import 'package:flutter/material.dart';

void main() => runApp(const ContactApp());

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFC1A8), // Botón flotante en color naranja
        ),
      ),
      home: const ContactScreen(),
      debugShowCheckedModeBanner: false,
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
  final List<Map<String, String>> _names = [];
  final List<Map<String, String>> _predefinedNames = [
    {'name': 'Darío Antonio Gutiérrez Álvarez', 'matricula': '221245'},
    {'name': 'Luis Alejandro Martinez Montoya', 'matricula': '213021'}
  ];
  bool _showNames = true;

  void _toggleNames() {
    setState(() {
      if (_showNames) {
        if (_names.isNotEmpty) {
          for (int i = _names.length - 1; i >= 0; i--) {
            _listKey.currentState?.removeItem(
              i,
              (context, animation) => _buildItem(_names[i], animation),
              duration: const Duration(milliseconds: 500),
            );
          }
          _names.clear();
        }
      } else {
        for (int i = 0; i < _predefinedNames.length; i++) {
          _names.add(_predefinedNames[i]);
          _listKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 500));
        }
      }
      _showNames = !_showNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Para que el gradiente esté detrás del AppBar
      appBar: AppBar(
        title: const Text('Contactos', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String value) {
              // Acción de menú seleccionada
            },
            itemBuilder: (BuildContext context) {
              return {'Configurar', 'Ayuda'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFDE5E7), Color(0xFFFFC1A8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Lista animada de contactos
          Padding(
            padding: const EdgeInsets.only(top: 100.0), // Ajuste para dejar espacio al AppBar
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _names.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_names[index], animation);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleNames,
        tooltip: 'Agregar Contactos',
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0xFFFFC1A8), // Naranja personalizado
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        elevation: 10,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {},
              ),
              const SizedBox(width: 30), // Espacio para el botón flotante
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Map<String, String> contact, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6, // Elevación para sombras suaves
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFC1A8),
            child: Text(
              contact['name']![0], // Inicial del nombre
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact['name']!),
          subtitle: Text('Matrícula: ${contact['matricula']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  _showSnackbarMessage('Llamando a ${contact['name']}');
                },
              ),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.blue),
                onPressed: () {
                  _showSnackbarMessage('Enviando mensaje a ${contact['name']}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
