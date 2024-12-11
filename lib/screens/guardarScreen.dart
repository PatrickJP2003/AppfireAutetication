import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Guardar extends StatelessWidget {
  const Guardar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guardar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: formularioGuardar(),
      ),
    );
  }
}

Widget formularioGuardar() {
  final TextEditingController _cedula = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _edad = TextEditingController();
  final TextEditingController _ciudad = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
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
        keyboardType: TextInputType.numberWithOptions(),
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
        onPressed: () => guardar(_cedula.text, _nombre.text, _edad.text, _ciudad.text),
        child: const Text("Guardar"),
      ),
    ],
  );
}
 
Future <void> guardar(cedula, nombre, edad, ciudad) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/"+ cedula);

await ref.set({
  "nombre": nombre,
  "edad": edad,
  "ciudad": ciudad
  
});
}