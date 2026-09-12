import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.grey.shade100,
              borderRadius: BorderRadius.circular(16.r),
              border: Border(
                top: BorderSide(color: context.colors.sky.shade500, width: 5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Form(
                key: _formKey,
                child: BlocListener<AuthCubit, AppStates>(
                  listener: (context, state) {
                    if (state == AppStates.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppString.checkYourEmail),
                          backgroundColor: context.colors.green,
                        ),
                      );
                    } else if (state == AppStates.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _authCubit.errorMessage??'An error occurred',
                          ),
                          backgroundColor: context.colors.error,
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        AppString.forgetPassword,
                        style: TextStyle(
                          color: context.colors.blue.shade500,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        AppString.enterYourEmailToRecieve,
                        style: TextStyle(
                          color: context.colors.blue.shade500,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24.h),
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
                      SizedBox(height: 24.h),
                      CustomeElevatebotton(
                        text: AppString.sendResetLink,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: context.colors.white,
                        ),
                        loadingState: AppStates.loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _authCubit.resetPassword(_emailController.text.trim());
                          }
                        },
                      ),
                    
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () => context.go('loginScreen'),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: context.colors.sky.shade700,
                              size: 16,
                            ),
                            Text(
                              AppString.backToLogin,
                              style: TextStyle(
                                color: context.colors.sky.shade700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      TextButton(
                        onPressed: () => context.go('resetPasswordScreen'),
                        child: Text('Reset Password'),
                      ),
                    ],
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
