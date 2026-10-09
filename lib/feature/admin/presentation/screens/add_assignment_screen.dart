import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/discard_dialog.dart';
import '../../../../app/theme/app_colors.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../data/models/add_assignment_model.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../manager/admin_cubit.dart';

class AddAssignmentScreen extends StatefulWidget {
  final int sessionId; // NEW

  const AddAssignmentScreen({super.key, required this.sessionId});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _deadlineController;
  late final TextEditingController _urlController;
  late final AdminCubit _cubit;
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _deadlineController = TextEditingController();
    _urlController = TextEditingController();
    _cubit = AdminCubit(
      repository: AdminRepositoryImpl(
        remoteDataSource: AdminRemoteDataSourceImpl(),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _deadlineController.dispose();
    _urlController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _deadlineController.clear();
    _urlController.clear();
    _deadline = null;
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline ?? now),
    );
    if (time == null || !mounted) return;

    setState(() {
      _deadline = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _deadlineController.text =
          '${date.day}/${date.month}/${date.year}  ${time.format(context)}';
    });
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
    return BlocListener<AdminCubit, AdminState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is AdminAssignmentAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Assignment added'),
              backgroundColor: context.colors.green,
            ),
          );
          context.pop();
        } else if (state is AdminError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colors.error,
            ),
          );
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
                    style: TextStyle(
                      color: context.colors.primary,
                      fontSize: 16,
                    ),
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
                    text: AppString.date,
                    hintText: AppString.mdy,
                    suffixIcon: Icon(Icons.date_range_outlined),
                    controller: _dateController,
                    validator: (value) => Validations.validateRequired(
                      value,
                      AppString.date ,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: _pickDeadline,
                    child: AbsorbPointer(
                      child: CustomeTextformfield(
                        text: AppString.deadLine,
                        hintText: AppString.mdy,
                        suffixIcon: Icon(Icons.access_time),
                        controller: _deadlineController,
                        validator: (value) => Validations.validateRequired(
                          value,
                          AppString.deadLine,
                        ),
                      ),
                    ),
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
                    text: AppString.saveAss,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      if (_cubit.state is AdminLoading) {
                        return; // no double submit
                      }

                      _cubit.addAssignment(
                        AddAssignment(
                          sessionId: widget.sessionId,
                          title: _titleController.text.trim(),
                          deadline: _deadline!,
                          assignmentUrl: _urlController.text.trim(),
                        ),
                      );
                    },
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
