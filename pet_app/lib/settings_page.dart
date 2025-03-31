import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'user_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.databaseService,
    required this.credentials,
  });
  final DatabaseServices databaseService;
  final UserState credentials;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  final DatabaseServices _databaseService = DatabaseServices.instance;

  final TextEditingController _waterReminderController =
      TextEditingController();
  final TextEditingController _foodReminderController = TextEditingController();
   late Future<int?> waterSchedule;
   late Future<int?> foodSchedule;

  @override
  void initState() {
    super.initState();
    int? petId = widget.credentials.petId;
    waterSchedule = _databaseService.getWaterSchedule(petId);
    foodSchedule = _databaseService.getFoodSchedule(petId);
  }

  void changeReminders() async {
    if (_formKey.currentState!.validate()) {
      int? waterReminder = int.tryParse(_waterReminderController.text.trim());
      int? foodReminder = int.tryParse(_foodReminderController.text.trim());
      int? petId = widget.credentials.petId;

      if (waterReminder == null || waterReminder <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid reminder interval')),
        );
        return;
      }

      if (foodReminder == null || foodReminder <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid reminder interval')),
        );
        return;
      }

      try {
        await _databaseService.updateReminders(petId, waterReminder, foodReminder);
        
        if (mounted) {
          setState(() {
            waterSchedule = _databaseService.getWaterSchedule(petId);
            foodSchedule = _databaseService.getFoodSchedule(petId);
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Schedules updated successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating schedules: $e')),
          );
        }
      }
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    int? petId = widget.credentials.petId;

    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: OvalBorder(),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 247,
              height: 36,
              child: Text(
                capitalizeFirstLetter(widget.credentials.firstName.toString()),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 247,
              height: 36,
              child: Text(
                widget.credentials.username.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 369,
              height: 36,
              child: Text(
                'Schedule Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<int?>(
                future: waterSchedule, // Use the future here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Loading water schedule...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Show error message
                    return Text(
                      'Error loading schedule: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text(
                      'No water schedule available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    // Here, you have the data available
                    return Text(
                      'You get water reminders every ${snapshot.data} hours',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<int?>(
                future: foodSchedule,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Loading food schedule...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error loading schedule: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text(
                      'No food schedule available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    return Text(
                      'You get food reminders every ${snapshot.data} hours',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ), // Add some padding
              child: Text(
                'Change Reminder Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.visible, // Ensures text is not cut off
                softWrap: true, // Allows text to wrap
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        FutureBuilder<int?>(
                          future: waterSchedule,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return TextFormField(
                                controller: _waterReminderController,
                                decoration: const InputDecoration(
                                  labelText: 'Loading water schedule...',
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return TextFormField(
                                controller: _waterReminderController,
                                decoration: const InputDecoration(
                                  labelText: 'Error loading schedule',
                                ),
                              );
                            } else {
                              return TextFormField(
                                controller: _waterReminderController,
                                decoration: InputDecoration(
                                  labelText:
                                      'Remind water every ${snapshot.data ?? "__"} hours',
                                ),
                              );
                            }
                          },
                        ),

                        TextFormField(
                          controller: _foodReminderController,
                          decoration: InputDecoration(
                            labelText: 'Remind food every __ (hours)',
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Enter a reminder interval'
                                      : null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          changeReminders();
                        }
                      },
                      child: const Text('Change'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
