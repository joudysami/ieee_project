import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/helpers/validation/app_validators.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String oobCode;
  const ResetPasswordScreen({super.key, required this.oobCode});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
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
            child: Form(
              key: _formKey,
              child: BlocListener<AuthCubit, AppStates>(
                listener: (context, state) {
                  if (state == AppStates.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppString.resetedSucces),
                        backgroundColor: context.colors.green,
                      ),
                    );
                    context.go('loginScreen');
                  } else if (state == AppStates.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'An error occurred ${_authCubit.errorMessage}',
                        ),
                        backgroundColor: context.colors.error,
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Text(
                      AppString.resetPassword,
                      style: TextStyle(
                        color: context.colors.blue.shade500,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      AppString.plaseEnterNewPassword,
                      style: TextStyle(
                        color: context.colors.blue.shade500,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomeTextformfield(
                      text: AppString.newPassword,
                      hintText: AppString.enterYourPassword,
                      icon: Icon(Icons.lock),
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.passwordIsRequired;
                        }
                        if (!Validations.validatePassword(value)) {
                          return AppString.registrationPasswordRequirement;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 18.h),
                    CustomeTextformfield(
                      text: AppString.confirmPassword,
                      // hintText: ,
                      icon: Icon(Icons.lock),
                      controller: _confirmPasswordController,
                      validator: (value) =>
                          AppValidators.confirmPasswordValidator(
                            value,
                            _passwordController.text,
                          ),
                    ),
                    SizedBox(height: 18.h),
                    CustomeElevatebotton(
                      text: AppString.resetPassword,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: context.colors.white,
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _authCubit.confirmPasswordReset(
                            code: widget.oobCode,
                            newPassword: _passwordController.text.trim(),
                          );
                        }
                      },
                      loadingState: AppStates.loading,
                    ),
                    SizedBox(height: 18.h),
                    TextButton(
                      onPressed: () => context.go('/loginScreen'),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: context.colors.sky.shade700,
                            size: 16,
                          ),
                          Text(
                            AppString.returnToLogin,
                            style: TextStyle(
                              color: context.colors.sky.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
