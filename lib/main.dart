import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app_widget.dart';
import 'src/core/di/dependency_manager.dart';
import 'src/core/utils/utils.dart';
import 'dart:io' show Platform;

void main() async {
  await MyApp.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Configurar dependencias
    setUpDependencies();

    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      doWhenWindowReady(() {
        const initialSize = Size(1280, 720);
        const minSize = Size(1024, 576);
        const maxSize = Size(1280, 720);
        appWindow.maxSize = maxSize;
        appWindow.minSize = minSize;
        appWindow.size = initialSize; // Tamaño por defecto
        appWindow.show();
      });
    }

    // Inicialización de almacenamiento local
    await LocalStorage.init();

    // Configuración de orientación de pantalla
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: AppWidget());
  }
}
