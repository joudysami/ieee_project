import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/theme/app_colors.dart';

Future<bool?> showDiscardDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white, 
      surfaceTintColor: Colors.transparent,
      title: const Text('Discard Changes?'),
      content: const Text('Are you sure you want to discard your changes? All entered data will be cleared.'),
      actions: [
        TextButton(
          onPressed: () => ctx.pop(false), 
          child:  Text('Cancel', style: TextStyle(color:context.colors.black)),
        ),
        TextButton(
          onPressed: () => ctx.pop(true), 
          child:  Text('OK', style: TextStyle(color:context.colors.sky.shade500)),
        ),
      ],
    ),
  );
}