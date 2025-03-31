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

/**
 * Will need a reminder class that starts timer
 * Will need a reminder list where reminders are stored
 * Reminders will be deleted after their are 10 reminders on the screen
 * Reminders will be displayed in a list view
 * Reminder will display what time the reminder what sent, the type of reminder
 * There will be 2 lists of randomixed reminders for food and water, everytime a reminder is created it will select randomly from the correct list
 * 
 */
