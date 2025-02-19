import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// para hacer commit
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app_widget.dart';
import 'src/core/di/dependency_manager.dart';
import 'src/core/utils/utils.dart';
import 'dart:io' show Platform;

void main() async {                                   
  WidgetsFlutterBinding.ensureInitialized();

  // Verificar que Firebase solo se inicialice una vez
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDAJf5M-gYbrbA-Pvxoi41UkBVprQWlTCc",
        // authDomain: "TU_AUTH_DOMAIN",
        projectId: "kibbi-kiosk",
        storageBucket: "kibbi-kiosk.firebasestorage.app",
        messagingSenderId: "748500030400",
        appId: "1:748500030400:ios:87044cf040f76776a3ae25",
      ),
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  setUpDependencies();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(1280, 720);
      const minSize = Size(1024, 576);
      const maxSize = Size(1280, 720);
      appWindow.maxSize = maxSize;
      appWindow.minSize = minSize;
      appWindow.size = initialSize; //default size
      appWindow.show();
    });
    
  }

  // Inicialización de almacenamiento local
  await LocalStorage.init();

  // Configuración de orientación de pantalla
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(const ProviderScope(child: AppWidget()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Aquí no es necesario inicializar Firebase nuevamente, solo manejar los mensajes
  print("Recibiendo mensaje en segundo plano: ${message.messageId}");
}