import 'package:extension_notas_flutter_chorme/controller/controller_notas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class CrearNota extends StatefulWidget {
  const CrearNota({super.key});

  @override
  State<CrearNota> createState() => _CrearNotaState();
}

class _CrearNotaState extends State<CrearNota> {
  final _formKey = GlobalKey<FormState>();
  String? _tituloNota;
  String? _descripiconNota;
  DateTime? _fechaCreacion;
  final TextEditingController _fechaCreacionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fechaCreacion = DateTime.now();
    _fechaCreacionController.text = DateFormat("dd/MM/yyyy").format(_fechaCreacion!);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerNotas>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Nota")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 10,left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  label: Text("Fecha creacion"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                controller: _fechaCreacionController,
                validator: Validatorless.multiple([
                  Validatorless.required("Este campo es requerido"),
                ]),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: Text("Ingresar titulo"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                onSaved: (newValue) {
                  _tituloNota = newValue;
                },
                validator: Validatorless.multiple([
                  Validatorless.required("Este campo es requerido"),
                  Validatorless.regex(
                    RegExp(r'^[a-zA-Z\s]+$'),
                    "Solo se permiten letras y espacios",
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: Text("Descripcion"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                keyboardType: TextInputType.multiline, 
                minLines: 3,
                maxLines: 5, 
                onSaved: (newValue) {
                  _descripiconNota = newValue;
                },
                validator: Validatorless.multiple([
                  Validatorless.required("Este campo es requerido"),
                  Validatorless.regex(
                    RegExp(r'^[a-zA-Z\s]+$'),
                    "Solo se permiten letras y espacios",
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    controller.crearNota(_fechaCreacion!, _tituloNota!, _descripiconNota!);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
