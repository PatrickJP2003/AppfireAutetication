import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Leer extends StatelessWidget {
  const Leer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leer Screen"),

      ),
      body: usuario_ListV(),
    );
  }
}

Future<List<Map<String, dynamic>>> leer() async {
  // Obtiene la referencia de los datos en Firebase
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('usuarios/');
  
  // Usamos get() para obtener los datos de una sola vez
  final snapshot = await starCountRef.get();  
  final data = snapshot.value;

  // Verificamos que los datos no sean nulos
  if (data != null) {
    // Realizamos un cast explícito a Map<dynamic, dynamic>
    Map<dynamic, dynamic> mapData = data as Map<dynamic, dynamic>;

    List<Map<String, dynamic>> userList = [];

    // Recorremos el mapa y lo convertimos en una lista de mapas
    mapData.forEach((key, value) {
      userList.add({
        'cedula': key,  // Usamos la clave como id
        'nombre': value['nombre'],  // Nombre del usuario
        'edad': value['edad'],  // Género del usuario
        'ciudad': value['ciudad'],  // Edad del usuario
      });
    });

    return userList;  // Devolvemos la lista de usuarios
  } else {
    return [];  // Si no hay datos, devolvemos una lista vacía
  }
}


Widget usuario_ListV(){
return FutureBuilder(future: leer(), builder: (context, snapshot) {
  if( snapshot.hasData){
final data = snapshot.data!;

return ListView.builder(itemCount: data.length,  itemBuilder: (context, index){  
  final item = data[index];

  return ListTile(
    title: Text(item['nombre']),
    subtitle: Text(item['edad'].toString()),
    trailing: Text(item['ciudad']),
  );
});
  }else{
    return Text("No hay datos");
  }
});
}

            