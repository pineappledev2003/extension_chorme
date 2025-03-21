import 'package:extension_notas_flutter_chorme/controller/controller_notas.dart';
import 'package:extension_notas_flutter_chorme/models/notas.dart';
import 'package:extension_notas_flutter_chorme/view/crear_nota.dart';
import 'package:extension_notas_flutter_chorme/view/lista_notas.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NotasAdapter());
  await Hive.openBox<Notas>("notasbox");
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ControllerNotas())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      initialRoute: "/listaNota",
      routes: {
        "/listaNota": (context) => const ListaNota(),
        "/crearNota": (context) => const CrearNota(),
      },
    );
  }
}
