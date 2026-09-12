import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final AuthCubit _authCubit;
  bool isRememberMe = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Container(
            width: double.infinity,
            // height: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.grey.shade100,
              borderRadius: BorderRadius.circular(16.r),
              border: Border(
                top: BorderSide(color: context.colors.sky.shade500, width: 5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Form(
                  key: _formKey,
                  child: BlocListener<AuthCubit, AppStates>(
                    listener: (context, state) async {
                      if (state == AppStates.success) {
                        final role = context.read<AuthCubit>().userRole;

                        if (isRememberMe) {
                          await CacheHelp.saveUserSession(
                            isRemembered: true,
                            role: role ?? 'Student',
                          );
                        } else {
                          await CacheHelp.clearSession();
                        }
                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login successful!'),
                            backgroundColor: context.colors.green,
                          ),
                        );

                        if (role == 'Admin') {
                          context.go('/adminScreen');
                        } else if (role == 'Student') {
                          context.go('/studentScreen');
                        }
                      } else if (state == AppStates.neededCompleteProfile) {
                        context.go('/completeProfileScreen');
                      } else if (state == AppStates.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Login failed! ${_authCubit.errorMessage}',
                            ),
                            backgroundColor: context.colors.error,
                          ),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Text(
                          AppString.welcome,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colors.blue.shade500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppString.continueToDashboard,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colors.blue.shade500,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomeTextformfield(
                          text: AppString.email,
                          hintText: AppString.enterYourEmail,
                          icon: Icon(Icons.email),
                          controller: _emailController,
                          validator: (value) {
                            return Validations.validateEmail(value ?? '')
                                ? null
                                : AppString.pleaseEnterValidEmail;
                          },
                        ),
                        SizedBox(height: 20.h),

                        CustomeTextformfield(
                          text: AppString.password,
                          hintText: AppString.enterYourPassword,
                          icon: Icon(Icons.lock),
                          controller: _passwordController,
                          validator: (value) {
                            return Validations.validatePassword(value ?? '')
                                ? null
                                : AppString.passwordRequirement;
                          },
                        ),

                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              final email = _emailController.text;
                              if (Validations.validateEmail(email)) {
                                context.go(
                                  '/forgotPasswordScreen',
                                  extra: email,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppString.pleaseEnterValidEmail,
                                    ),
                                    backgroundColor: context.colors.error,
                                  ),
                                );
                              }
                            },

                            child: Text(
                              AppString.forgetPassword,
                              style: TextStyle(
                                color: context.colors.sky.shade700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Checkbox(
                              value: isRememberMe,
                              activeColor: context.colors.primary,
                              onChanged: (value) {
                                setState(() {
                                  isRememberMe = value ?? false;
                                });
                              },
                            ),
                            Text(
                              AppString.rememberMe,
                              style: TextStyle(color: context.colors.primary),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),
                        CustomeElevatebotton(
                          text: AppString.login,
                          icon: Icon(Icons.login, color: context.colors.white),
                          loadingState: AppStates.loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _authCubit.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          },
                        ),

                        SizedBox(height: 20.h),

                        CustomeElevatebotton(
                          text: AppString.loginWithGoogle,
                          icon: Icon(Icons.login, color: context.colors.white),
                          loadingState: AppStates.googleLoading,
                          onTap: () {
                            _authCubit.signInWithGoogle();
                          },
                        ),

                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.dontHaveAccount,
                              style: TextStyle(
                                color: context.colors.blue.shade500,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go('/registerScreen'),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: context.colors.sky.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: () => context.go('/completeProfileScreen'),
                          child: Text('Complate data'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
