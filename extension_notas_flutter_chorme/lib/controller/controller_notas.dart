import 'package:extension_notas_flutter_chorme/models/notas.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ControllerNotas extends ChangeNotifier {
  late Box<Notas> _notasBox;
  List<Notas> _notasRegistradas = [];

  ControllerNotas() {
    cargarNotas();
  }

  /// 🔹 Inicializa la caja de Hive una vez
  Future<void> _abrirCaja() async {
    _notasBox = await Hive.openBox<Notas>('notasBox');
  }

  /// 🔹 Cargar las notas al iniciar
  Future<void> cargarNotas() async {
    await _abrirCaja();
    _notasRegistradas = _notasBox.values.toList();
    notifyListeners();
  }

  /// 🔹 Agregar una nueva nota
  Future<void> crearNota(DateTime fechaCreacion, String tituloNota, String descripcionNota) async {
    await _abrirCaja();
    Notas nuevaNota = Notas(
      fechaCreacion: fechaCreacion,
      tituloNota: tituloNota,
      descripcionNota: descripcionNota,
    );

    await _notasBox.add(nuevaNota); // ✅ Se guarda como un nuevo elemento en Hive
    _notasRegistradas = _notasBox.values.toList(); // ✅ Se actualiza la lista
    notifyListeners();
  }

  /// 🔹 Obtener todas las notas
  List<Notas> get obtenerNotas {
    return _notasRegistradas;
  }

  /// 🔹 Eliminar una nota por índice
  Future<void> eliminarNota(int index) async {
    await _abrirCaja();
    await _notasBox.deleteAt(index); // ✅ Elimina la nota de Hive
    _notasRegistradas = _notasBox.values.toList(); // ✅ Se actualiza la lista
    notifyListeners();
  }
}
