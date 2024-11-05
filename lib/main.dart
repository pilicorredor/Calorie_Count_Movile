import 'package:calorie_counter/pages/home_page.dart';
import 'package:calorie_counter/pages/login_page.dart'; // Importa la página de Login
import 'package:calorie_counter/pages/sign_up_page.dart';
import 'package:calorie_counter/permissions/permissions_screen.dart';
import 'package:calorie_counter/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()), // Proveedor para manejar el estado de la barra de navegación
      ],
      child: MaterialApp(
        title: 'Calorie Counter',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate ],
        supportedLocales:  const [
        Locale('en'),
        Locale('es'),
      ],
        initialRoute: 'login', // Cambia la ruta inicial a la página de login
        routes: {
          'login': (_) => const LoginPage(), // Agrega la ruta para LoginPage
          'home': (_) => const HomePage(),   // Ruta para HomePage
          'SingUp': (_) => const SignUpPage(),
          '/permissions': (_) => const PermissionsScreen() 
        },
      ),
    );
  }
}
