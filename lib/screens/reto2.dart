import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reto2Screen extends StatelessWidget {
  const Reto2Screen({Key? key}) : super(key: key);

  // Método para obtener tareas desde una API simulada
  Future<List<String>> _fetchTasks() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Extraer solo los títulos de las tareas
      return data.map((task) => task['title'] as String).toList();
    } else {
      throw Exception('Error al cargar las tareas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reto 2',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: _fetchTasks(),
          builder: (context, snapshot) {
            // Mientras se espera la respuesta, mostrar un indicador de carga
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Si hay un error en la solicitud
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            // Si se obtienen los datos correctamente
            if (snapshot.hasData) {
              final tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskItem(tasks[index]);
                },
              );
            }
            // Caso en el que no haya datos
            return const Center(child: Text('No hay tareas disponibles'));
          },
        ),
      ),
    );
  }

  // Widget para mostrar cada tarea
  Widget _buildTaskItem(String task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.task_alt, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              task,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
