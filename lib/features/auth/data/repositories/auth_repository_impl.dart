import 'package:fake_store/core/shared/constants/app_constants.dart';

import '../../../../core/network/dio_helper.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String username, String password) async {
    final response = await DioHelper.postData(
      url: '${AppConstants.baseUrl}/auth/login',
      data: {'email': username, 'password': password},
    );

    final loginResponse = LoginResponse.fromJson(response.data);

    return User(token: loginResponse.token);
  }
}
