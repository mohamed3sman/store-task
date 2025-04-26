import '../../../../core/network/dio_helper.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String username, String password) async {
    final response = await DioHelper.postData(
      url: 'https://fakestoreapi.com/auth/login',
      data: {'username': username, 'password': password},
    );

    final loginResponse = LoginResponse.fromJson(response.data);

    return User(token: loginResponse.token);
  }
}
