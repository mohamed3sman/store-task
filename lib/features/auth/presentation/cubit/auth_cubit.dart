import 'package:fake_store/core/network/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:dio/dio.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SecureStorageService secureStorageService;

  AuthCubit(this.loginUseCase, this.secureStorageService)
    : super(AuthInitial());

  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  bool isPasswordVisible = false;

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(username, password);
      await secureStorageService.saveToken(user.token);
      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(
        AuthFailure(e.response?.data['message'] ?? 'Unknown error occurred'),
      );
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  void loginButtonPressed(context) {
    if (form.valid) {
      final username = form.control('email').value as String;
      final password = form.control('password').value as String;
      login(username, password);
    } else {
      form.markAllAsTouched();
    }
  }

  void passwordEyeTapped() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordEyeChanged());
  }
}
