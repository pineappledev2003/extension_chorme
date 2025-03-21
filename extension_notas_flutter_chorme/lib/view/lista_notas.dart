import 'package:extension_notas_flutter_chorme/controller/controller_notas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListaNota extends StatefulWidget {
  const ListaNota({super.key});

  @override
  State<ListaNota> createState() => _ListaNotaState();
}

class _ListaNotaState extends State<ListaNota> {
  late Future<void> _cargarNotasFuture;

  @override
  void initState() {
    super.initState();
    final controllerNotas = Provider.of<ControllerNotas>(context, listen: false);
    _cargarNotasFuture = controllerNotas.cargarNotas();
  }

  @override
  Widget build(BuildContext context) {
    final controllerNotas = Provider.of<ControllerNotas>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de notas")),
      body: FutureBuilder(
        future: _cargarNotasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controllerNotas.obtenerNotas.isEmpty) {
            return const Center(
              child: Text("No hay notas registradas"),
            );
          }

          return ListView.builder(
            itemCount: controllerNotas.obtenerNotas.length,
            itemBuilder: (context, index) {
              final nota = controllerNotas.obtenerNotas[index];

              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    nota.obtenerTituloNota,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nota.obtenerDescripcion),
                      const SizedBox(height: 5),
                      Text(
                        "Fecha: ${DateFormat("dd/MM/yyyy").format(nota.obtenerFechaCreacion)}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controllerNotas.eliminarNota(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/crearNota");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
