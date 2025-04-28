import 'package:fake_store/core/di/di.dart';
import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_images.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:fake_store/core/shared/widgets/custom_button.dart';
import 'package:fake_store/core/shared/widgets/custom_reative_text_field.dart';
import 'package:fake_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
            final cubit = context.read<AuthCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ReactiveForm(
                formGroup: cubit.form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Login Now...',
                      style: AppStyles.styleMedium20.copyWith(
                        color: Colors.black,
                        fontSize: getResponsiveFontSize(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 7),
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
                    const SizedBox(height: 10),
                    // ReactiveTextField<String>(
                    //   formControlName: 'email',
                    //   style: AppStyles.styleRegular16,
                    //   decoration: InputDecoration(
                    //     labelText: 'Email',
                    //     labelStyle: AppStyles.styleMedium18,
                    //     contentPadding: EdgeInsets.zero,
                    //     border: const UnderlineInputBorder(),
                    //   ),
                    //   validationMessages: {
                    //     ValidationMessage.required:
                    //         (error) => 'Email is required',
                    //     ValidationMessage.email:
                    //         (error) => 'Invalid email format',
                    //   },
                    // ),
                    // const SizedBox(height: 15),
                    // ReactiveTextField<String>(
                    //   formControlName: 'password',
                    //   style: AppStyles.styleRegular16,
                    //   obscureText: !cubit.isPasswordVisible,
                    //   decoration: InputDecoration(
                    //     labelText: 'Password',
                    //     labelStyle: AppStyles.styleMedium18,
                    //     contentPadding: EdgeInsets.zero,
                    //     border: const UnderlineInputBorder(),
                    //     suffixIcon: IconButton(
                    //       icon: Icon(
                    //         cubit.isPasswordVisible
                    //             ? Icons.visibility
                    //             : Icons.visibility_off,
                    //       ),
                    //       onPressed: cubit.passwordEyeTapped,
                    //     ),
                    //   ),
                    //   validationMessages: {
                    //     ValidationMessage.required:
                    //         (error) => 'Password is required',
                    //   },
                    // ),
                    CustomReactiveTextField(
                      formControlName: 'email',
                      label: 'Email',
                      validationMessages: {
                        ValidationMessage.required:
                            (error) => 'Email is required',
                        ValidationMessage.email:
                            (error) => 'Invalid email format',
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomReactiveTextField(
                      formControlName: 'password',
                      label: 'Password',
                      obscureText: !cubit.isPasswordVisible,
                      showEyeIcon: true,
                      onEyeTap: cubit.passwordEyeTapped,
                      validationMessages: {
                        ValidationMessage.required:
                            (error) => 'Password is required',
                      },
                    ),

                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: AppStyles.styleRegular16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      text: 'Login',
                      isLoading: state is AuthLoading,
                      onPressed: () => cubit.loginButtonPressed(context),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
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
                    const SizedBox(height: 15),
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
