import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/discard_dialog.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _durationController;
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _durationController = TextEditingController();
    _urlController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _durationController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _durationController.clear();
    _urlController.clear();
  }

  Future<void> _handleDiscard() async {
    final shouldDiscard = await showDiscardDialog(context);

    if (shouldDiscard == true) {
      _clearFields();
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 25.w),
                    Text(
                      AppString.addAss,
                      style: TextStyle(
                        color: context.colors.primary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Text(
                  AppString.mangeAllAss,
                  style: TextStyle(color: context.colors.primary, fontSize: 16),
                ),
                SizedBox(height: 12.h),
                CustomeTextformfield(
                  text: AppString.assTitle,
                  hintText: AppString.introToReact,
                  controller: _titleController,
                  validator: (value) =>
                      Validations.validateRequired(value, AppString.assTitle),
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
                CustomeTextformfield(
                  text: AppString.scheduledDate,
                  hintText: AppString.mdy,
                  suffixIcon: Icon(Icons.date_range_outlined),
                  controller: _dateController,
                  validator: (value) => Validations.validateRequired(
                    value,
                    AppString.scheduledDate,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomeTextformfield(
                  text: AppString.deadLine,
                  hintText: AppString.mdy,
                  suffixIcon: Icon(Icons.access_time),
                  controller: _durationController,
                  validator: (value) =>
                      Validations.validateRequired(value, AppString.deadLine),
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
                  style: TextStyle(color: context.colors.primary, fontSize: 16),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Divider(),
                ),
                SizedBox(height: 12.h),
                CustomElevatedButton(
                  text: AppString.saveAss,
                  onTap: () {},
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
    );
  }
}
