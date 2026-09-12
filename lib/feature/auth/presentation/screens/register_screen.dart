import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/helpers/validation/app_validators.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_dropDownField.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final AuthCubit _authCubit;

  String? _selectedRole;
  String? _selectedInstitute;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: SingleChildScrollView(
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
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Form(
                key: _formKey,
                child: BlocListener<AuthCubit, AppStates>(
                  listener: (context, state) {
                    if (state == AppStates.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Successfully Registered'),
                          backgroundColor: context.colors.green,
                        ),
                      );
                      final role = context.read<AuthCubit>().userRole;
                      if (role == 'Admin') {
                        context.go('/adminScreen');
                      } else if (role == 'Student') {
                        context.go('/studentScreen');
                      }
                    } else if (state.isNeededCompleteProfile) {
                      _authCubit.completeProfile(
                        phone: _phoneController.text,
                        institute: _selectedInstitute!,
                        enrollment: _selectedRole!,
                      );
                    } else if (state == AppStates.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'failed to Register: ${_authCubit.errorMessage}',
                          ),
                          backgroundColor: context.colors.error,
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        AppString.createAccount,
                        style: TextStyle(
                          color: context.colors.blue.shade500,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppString.joinAcadimic,
                        style: TextStyle(
                          color: context.colors.blue.shade500,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomeTextformfield(
                        text: AppString.name,
                        hintText: AppString.enterName,
                        icon: Icon(Icons.person),
                        controller: _nameController,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : AppString.pleaseEnterName;
                        },
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 16.h),
                      CustomeTextformfield(
                        text: AppString.password,
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
                      SizedBox(height: 16.h),
                      CustomeTextformfield(
                        text: AppString.confirmPassword,
                        hintText: AppString.enterYourPassword,
                        icon: Icon(Icons.lock),
                        controller: _confirmPasswordController,
                        validator: (value) =>
                            AppValidators.confirmPasswordValidator(
                              value,
                              _passwordController.text,
                            ),
                      ),
                      SizedBox(height: 16.h),
                      CustomeTextformfield(
                        text: AppString.phoneNumber,

                        icon: Icon(Icons.phone),
                        controller: _phoneController,
                        validator: (value) {
                          return Validations.validatePhone(value ?? '')
                              ? null
                              : AppString.validEgyptianPhone;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomDropDownField(
                        value: _selectedInstitute,
                        hint: AppString.selectInstitute,
                        label: AppString.institue,
                        items: ['CIS(CS)', 'CIS(IS)', 'MTF', 'ET5', 'AAI'],
                        onChanged: (value) {
                          setState(() {
                            _selectedInstitute = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.selectInstitute;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomDropDownField(
                        value: _selectedRole,
                        hint: AppString.selectRole,
                        label: AppString.enrollment,
                        items: ['Student', 'Admin'],
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.selectRole;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.alreadyHaveAccount,
                            style: TextStyle(
                              color: context.colors.blue.shade500,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/loginScreen'),

                            child: Text(
                              AppString.login,
                              style: TextStyle(
                                color: context.colors.sky.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      CustomeElevatebotton(
                        text: AppString.createAccount,
                        // icon: Icon(Icons.person_add, color: context.colors.white),
                        loadingState: AppStates.registerLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _authCubit.register(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _nameController.text.trim(),
                              _phoneController.text.trim(),
                              _selectedInstitute ?? '',
                              _selectedRole ?? '',
                            );
                          }
                        },
                      ),
                      SizedBox(height: 14.h),
                      CustomeElevatebotton(
                        text: AppString.createAccount,
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: context.colors.white,
                        ),
                        loadingState: AppStates.googleLoading,
                        onTap: () async {
                          if (_selectedInstitute == null ||
                              _selectedInstitute!.isEmpty ||
                              _selectedRole == null ||
                              _selectedRole!.isEmpty ||
                              _phoneController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppString.selectRollAndInstitute),
                                backgroundColor: context.colors.error,
                              ),
                            );
                            return;
                          }
                          await _authCubit.signInWithGoogle();
                        },
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
