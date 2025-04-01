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
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFF507E7F),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminders',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text('petName is getting hungry'),
                    subtitle: Text('Sent: 00/00/00 00:00 AM'),
                    leading: const Icon(Icons.notifications),
                  ),
                  ListTile(
                    title: Text('Make sure petName is hydrated'),
                    subtitle: Text('Sent: 00/00/00 00:00 AM'),
                    leading: const Icon(Icons.notifications),
                  ),
                  ListTile(
                    title: Text('Time for some nourishment'),
                    subtitle: Text('Sent: 00/00/00 00:00 AM'),
                    leading: const Icon(Icons.notifications),
                  ),
                ],
              ),
            );
  }
}

/**
 * Will need a reminder class that starts timer
 * Will need a reminder list where reminders are stored
 * Reminders will be deleted after their are 10 reminders on the screen
 * Reminder will display what time the reminder was sent, the type of reminder
 * There will be 2 lists of randomized reminders for food and water, everytime a reminder is created it will select randomly from the correct list
 * 
 */
