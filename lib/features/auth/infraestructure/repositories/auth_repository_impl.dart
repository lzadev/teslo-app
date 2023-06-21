import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/datasources/auth_datasouce_impl.dart';

class AuthRepsitoryImpl extends AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepsitoryImpl([AuthDataSource? authDataSource])
      : _authDataSource = authDataSource ?? AuthDataSourceImpl();

  @override
  Future<User> chechAuthStatus(String token) {
    return _authDataSource.chechAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return _authDataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return _authDataSource.register(email, password, fullName);
  }
}
