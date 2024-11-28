import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calorie_counter/models/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Establece un usuario
  void setUser(User user) {
    state = user;
  }

  // Limpia el usuario (ejemplo: logout)
  void clearUser() {
    state = null;
  }
}

// Define el provider
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
