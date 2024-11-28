import 'package:calorie_counter/pages/sign_up_page.dart';
import 'package:go_router/go_router.dart';
import 'package:calorie_counter/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    //builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/permissions',
    builder: (context, state) => const PermissionsScreen(),
  ),

    GoRoute(
    path: '/SingUp',
    builder: (context, state) => const SignUpPage(),
  ),
]);
