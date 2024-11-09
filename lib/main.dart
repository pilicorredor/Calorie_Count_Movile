import 'package:calorie_counter/pages/home_page.dart';
import 'package:calorie_counter/pages/login_page.dart';
import 'package:calorie_counter/pages/sign_up_page.dart';
import 'package:calorie_counter/permissions/permissions_screen.dart';
import 'package:calorie_counter/providers/app_state_provider.dart';
import 'package:calorie_counter/providers/permissions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:calorie_counter/providers/ui_provider.dart'; 
import 'package:provider/provider.dart' as provider; // Alias para provider


void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerStatefulWidget  {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    if (state == AppLifecycleState.resumed) {
      ref.read(permissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => UIProvider()), // El provider debe ser importado correctamente
      ],
      child: MaterialApp(
        title: 'Calorie Counter',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginPage(),
          'home': (_) => const HomePage(),
          'signUp': (_) => const SignUpPage(),
          '/permissions': (_) => const PermissionsScreen(),
        },
      ),
    );
  }
}


