import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/repositories/auth_repository_impl.dart';

import '../../infraestructure/errors/auth_errors.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepsitoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());

  void loginUser(String email, String password) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void _setLoggedUser(User user) {
    //TODO: SAVE THE TOKE IN THE DEVICE
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  void registerUser(String email, String passWord) async {}
  void checkAuthStatus() async {}

  Future<void> logout([String? errorMessage]) async {
    //TODO: CLEAR THE TOKEN
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
