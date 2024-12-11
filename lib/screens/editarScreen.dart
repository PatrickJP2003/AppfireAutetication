import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Editar extends StatelessWidget {
  const Editar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Firebase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            formularioEditar(),
            const SizedBox(height: 24),
            formularioEliminar(),
          ],
        ),
      ),
    );
  }
}

Widget formularioEditar() {
  final TextEditingController _cedula = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _edad = TextEditingController();
  final TextEditingController _ciudad = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: _cedula,
        decoration: const InputDecoration(
          label: Text("Cédula"),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _nombre,
        decoration: const InputDecoration(
          label: Text("Nombre"),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        keyboardType: TextInputType.number,
        controller: _edad,
        decoration: const InputDecoration(
          label: Text("Edad"),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _ciudad,
        decoration: const InputDecoration(
          label: Text("Ciudad"),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () => editar(
          _cedula.text,
          _nombre.text,
          _edad.text,
          _ciudad.text,
        ),
        child: const Text("Guardar"),
      ),
    ],
  );
}

Future<void> editar(String cedula, String nombre, String edad, String ciudad) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/$cedula");

  await ref.update({
    "nombre": nombre,
    "edad": edad,
    "ciudad": ciudad,
  });
}

Widget formularioEliminar() {
  final TextEditingController _cedula = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _cedula,
          decoration: InputDecoration(
            label: const Text("Cédula"),
            fillColor: const Color.fromRGBO(231, 52, 52, 1),
            filled: true,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
      IconButton(
        onPressed: () => eliminar(_cedula.text),
        icon: const Icon(Icons.delete),
        color: Colors.red,
      ),
    ],
  );
}

Future<void> eliminar(String cedula) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/$cedula");
  await ref.remove();
}
