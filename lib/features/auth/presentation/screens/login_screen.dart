import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_images.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/core/shared/constants/common_methods.dart';
import 'package:fake_store/core/shared/widgets/custom_button.dart';
import 'package:fake_store/core/shared/widgets/custom_text_field.dart';
import 'package:fake_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Successful: ${state.user.token}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Failed: ${state.error}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Form(
                key: context.read<AuthCubit>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Text(
                      'Login Now...',
                      style: AppStyles.styleMedium20.copyWith(
                        color: Colors.black,
                        fontSize: getResponsiveFontSize(fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start your shopping journey!',
                          style: AppStyles.styleMedium20.copyWith(
                            color: Colors.black,
                            fontSize: getResponsiveFontSize(fontSize: 24),
                          ),
                        ),
                        Image.asset(AppImages.shirt, width: 27),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      text: 'Email',
                      validator: (val) => validateField(value: val),
                      controller: context.read<AuthCubit>().usernameController,
                    ),
                    SizedBox(height: 7),
                    CustomTextField(
                      text: 'Password',
                      validator: (val) => validateField(value: val),
                      controller: context.read<AuthCubit>().passwordController,
                      hasSuffixIcon: true,
                      isPasswordVisible:
                          context.read<AuthCubit>().isPasswordVisible,
                      onEyeTap: context.read<AuthCubit>().passwordEyeTapped,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: AppStyles.styleRegular16,
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    CustomButton(
                      text: 'Login',
                      isLoading: state is AuthLoading,
                      onPressed:
                          () => context.read<AuthCubit>().loginButtonPressed(
                            context,
                          ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 15.5,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
