import 'package:fake_store/core/network/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase, this.secureStorageService)
    : super(AuthInitial());

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final SecureStorageService secureStorageService;
  final formKey = GlobalKey<FormState>();

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(username, password);
      await secureStorageService.saveToken(user.token);
      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailure(e.response?.data ?? 'Unknown error occurred'));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  loginButtonPressed(BuildContext context) {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // if (username.isEmpty || password.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Please fill all fields',
    //         style: AppStyles.styleMedium16.copyWith(color: Colors.white),
    //       ),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }
    if (formKey.currentState!.validate() == true) {
      BlocProvider.of<AuthCubit>(context).login(username, password);
    }
  }

  passwordEyeTapped() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordEyeChanged());
  }
}
