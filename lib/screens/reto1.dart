import 'package:flutter/material.dart';

class Reto1Screen extends StatefulWidget {
  const Reto1Screen({super.key});

  @override
  _Reto1ScreenState createState() => _Reto1ScreenState();
}

class _Reto1ScreenState extends State<Reto1Screen> {
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
      });
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reto 1',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextField para ingresar la tarea
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Ingrese una tarea',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  prefixIcon: const Icon(Icons.task, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón para agregar tarea
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Color de fondo del botón
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Agregar Tarea',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            // Lista de tareas
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay tareas agregadas',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return _buildTaskItem(_tasks[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar cada tarea
  Widget _buildTaskItem(String task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Colors.black),
        title: Text(
          task,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            setState(() {
              _tasks.remove(task);
            });
          },
        ),
      ),
    );
  }
}
