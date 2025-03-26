import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'login_page.dart';

class RemindersSection extends StatefulWidget {
  const RemindersSection({super.key});

  @override
  State<RemindersSection> createState() => _RemindersSectionState();
}

class _RemindersSectionState extends State<RemindersSection> {  
  final DatabaseServices _databaseService = DatabaseServices.instance;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text("Reminders"),
      ),
    );
  }
}
