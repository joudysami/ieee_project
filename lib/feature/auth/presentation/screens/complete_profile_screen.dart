import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_dropDownField.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late final TextEditingController _phoneController;
  late final AuthCubit _authCubit;

  String? _selectedRole;
  String? _selectedInstitute;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _authCubit = context.read<AuthCubit>();
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
                // left: BorderSide(color: context.colors.sky.shade500, width: 1),
                // right: BorderSide(color: context.colors.sky.shade500, width: 1),
                // bottom: BorderSide(color: context.colors.sky.shade500, width: 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: BlocListener<AuthCubit, AppStates>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Save successful'),
                        backgroundColor: context.colors.green,
                      ),
                    );
                    final role = context.read<AuthCubit>().userRole;
                    if (role == 'Admin') {
                      context.go('/adminScreen');
                    } else {
                      context.go('/studentScreen');
                    }
                  } else if (state.isError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Save failed! ${_authCubit.errorMessage}',
                        ),
                        backgroundColor: context.colors.error,
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Text(
                      AppString.complete,
                      style: TextStyle(
                        color: context.colors.blue.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
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
                      items: ['CIS(CS)','CIS(IS)', 'MTF', 'ET5','AAI'],
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
                    SizedBox(height: 20.h),
                    CustomeElevatebotton(
                      text: AppString.save,
                      loadingState: AppStates.neededCompleteProfile,
                      onTap: () async {
                        await _authCubit.completeProfile(
                          enrollment: _selectedRole ?? '',
                          phone: _phoneController.text,
                          institute: _selectedInstitute ?? '',
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.go('loginScreen'),
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: context.colors.sky.shade700,
                            fontSize: 16,
                          ),
                        ),
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
