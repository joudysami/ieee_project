import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/feature/admin/presentation/manager/admin_cubit.dart';
import 'package:ieee/feature/auth/data/model/user_model.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/discard_dialog.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _durationController;
  late final TextEditingController _urlController;
  late final TextEditingController _timeController;

  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _durationController = TextEditingController();
    _urlController = TextEditingController();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _durationController.dispose();
    _urlController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _durationController.clear();
    _urlController.clear();
    _timeController.clear();
  }
Widget _blueTheme(BuildContext context, Widget? child) {
  const blue = Colors.blue; // أو context.colors.sky.shade700

  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: blue,
            onPrimary: Colors.white,
            surface: Colors.white,              // خلفية الـ dialog
            onSurface: Colors.black,
            surfaceTint: Colors.transparent,    // يشيل الطبقة الموف
            surfaceContainerHigh: Colors.white, // خلفية الـ time picker
            surfaceContainerHighest: const Color(0xFFE3F2FD), // خلفية خانات الساعة والدقيقة
            secondary: blue,
            onSecondary: Colors.white,
            tertiary: blue,
          ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: Colors.blue,
        headerForegroundColor: Colors.white,
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: Colors.white,
        dialBackgroundColor: Color(0xFFE3F2FD),
        hourMinuteColor: Color(0xFFE3F2FD),
        hourMinuteTextColor: Colors.blue,
        dayPeriodColor: Color(0xFFE3F2FD),
        dayPeriodTextColor: Colors.blue,
        dialHandColor: Colors.blue,
        entryModeIconColor: Colors.blue,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: blue),
      ),
    ),
    child: child!,
  );
}
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder:_blueTheme,
    );
    if (picked != null) {
      _selectedDate = DateTime.utc(picked.year, picked.month, picked.day);
      _dateController.text = '${picked.month}/${picked.day}/${picked.year}';
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: _blueTheme,
    );
    if (picked != null) {
      final h = picked.hour.toString().padLeft(2, '0');
      final m = picked.minute.toString().padLeft(2, '0');
      _timeController.text = '$h:$m';
    }
  }

  void _saveSession() {
    if (!_formKey.currentState!.validate()) return;

    final UserModel? userData = CacheHelp.getUser();

    context.read<AdminCubit>().addSession(
      userData?.idTrack ?? '1',
      userData?.uId ?? '',
      _titleController.text.trim(),
      _descriptionController.text.trim(),
      _selectedDate!.toIso8601String(),
      _timeController.text,
      _durationController.text.trim(),
      _urlController.text.trim(),
    );
  }

  Future<void> _handleDiscard() async {
    final shouldDiscard = await showDiscardDialog(context);

    if (shouldDiscard == true) {
      if (!mounted) return;
      _clearFields();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminSessionAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Session added successfully')),
          );
          context.pop(true);
        } else if (state is AdminError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Text(
                    AppString.addSession,
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    AppString.configureDetails,
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomeTextformfield(
                    text: AppString.sessionTitle,
                    hintText: AppString.introToReact,
                    controller: _titleController,
                    validator: (value) => Validations.validateRequired(
                      value,
                      AppString.sessionTitle,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomeTextformfield(
                    text: AppString.description,
                    hintText: AppString.brieflyDescribe,
                    minLines: 4,
                    maxLines: 4,
                    controller: _descriptionController,
                    validator: (value) => Validations.validateRequired(
                      value,
                      AppString.description,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: AbsorbPointer(
                            child: CustomeTextformfield(
                              text: AppString.date,
                              hintText: AppString.mdy,
                              controller: _dateController,
                              suffixIcon: Icon(Icons.date_range_outlined),
                              validator: (value) =>
                                  Validations.validateRequired(
                                    value,
                                    AppString.date,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickTime,
                          child: AbsorbPointer(
                            child: CustomeTextformfield(
                              text: AppString.time,
                              hintText: AppString.hm,
                              controller: _timeController,
                              suffixIcon: Icon(Icons.date_range_outlined),
                              validator: (value) =>
                                  Validations.validateRequired(
                                    value,
                                    AppString.time,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomeTextformfield(
                    text: AppString.duration,
                    hintText: AppString.eg90,
                    suffixIcon: Icon(Icons.access_time),
                    controller: _durationController,
                    validator: (value) {
                      final required = Validations.validateRequired(
                        value,
                        AppString.duration,
                      );
                      if (required != null) return required;

                      final number = int.tryParse(value!.trim());
                      if (number == null || number <= 0) {
                        return 'Enter a valid duration in minutes';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h),
                  CustomeTextformfield(
                    text: AppString.externalResourse,
                    hintText: AppString.http,
                    controller: _urlController,
                    validator: (value) => Validations.validateRequired(
                      value,
                      AppString.externalResourse,
                    ),
                  ),
                  Text(
                    AppString.linkToPresentation,
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(),
                  ),
                  SizedBox(height: 12.h),
                  CustomElevatedButton(
                    text: AppString.saveSession,
                    onTap: _saveSession,
                    borderRadius: 20,
                  ),
                  SizedBox(height: 12.h),
                  CustomElevatedButton(
                    text: AppString.discardChange,
                    onTap: _handleDiscard,
                    textColor: context.colors.primary,
                    backgroundColor: context.colors.white,
                    borderColor: context.colors.primary,
                    borderRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
