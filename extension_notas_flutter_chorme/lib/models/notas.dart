import 'package:hive/hive.dart';

part 'notas.g.dart';

 @HiveType(typeId: 0)
class Notas extends HiveObject{

  @HiveField(0)
  DateTime? _fechaCreacion;

  @HiveField(1)
  String? _tituloNota;

   @HiveField(2)
  String? _descripcionNota;

  Notas({
    required DateTime fechaCreacion,
    required String tituloNota,
    required String descripcionNota,
  }) {
    _fechaCreacion = fechaCreacion;
    _tituloNota = tituloNota;
    _descripcionNota = descripcionNota;
  }

  set cambiarTituloNota(String nuevoTitulo) {
    _tituloNota = nuevoTitulo;
  }

  set cambiarDescripcionNota(String nuevaDescripcion) {
    _descripcionNota = nuevaDescripcion;
  }

  DateTime get obtenerFechaCreacion {
    return _fechaCreacion!;
  }

  String get obtenerTituloNota {
    return _tituloNota!;
  }

  String get obtenerDescripcion {
    return _descripcionNota!;
  }

  Map<String, dynamic> toJson() {
    return {
      "fechaCreacion": _fechaCreacion!.toIso8601String(),
      "titulo": _tituloNota,
      "Descripcion": _descripcionNota,
    };
  }

  factory Notas.formJson(Map<String, dynamic> json) {
    return Notas(
      fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      tituloNota: json["titulo"],
      descripcionNota: json["Descripcion"],
    );
  }
}
