import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infraestructure/mappers/user_mapper.dart';

import '../../domain/domain.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final _dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    ),
  );

  @override
  Future<User> chechAuthStatus(String token) async {
    try {
      final response = await _dio.get(
        'auth/check-status',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      final response = await _dio.post(
        '/auth/login',
        data: data,
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'credenciales no validas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('No intenert connection');
      }
      throw CustomError('Something wrong happened');
    } catch (e) {
      throw CustomError('Something wrong happened');
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
