import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'user_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.databaseService, required this.credentials});
  final DatabaseServices databaseService;
  final UserState credentials;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  final DatabaseServices _databaseService = DatabaseServices.instance;

  final TextEditingController _waterReminderController = TextEditingController();
  final TextEditingController _foodReminderController = TextEditingController();


  void changeReminders() async{
    if (_formKey.currentState!.validate()) {

      int? waterReminder = int.tryParse(_waterReminderController.text.trim());
      int? foodReminder = int.tryParse(_foodReminderController.text.trim());

      UserState localStorage = new UserState();

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

      _databaseService.updateReminders(localStorage.petId, waterReminder, foodReminder);

  

}}

  

  @override
  Widget build(BuildContext context) {
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
                'Pet Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 247,
              height: 36,
              child: Text(
                'Username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
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
            SizedBox(
              width: 337,
              height: 35,
              child: Text(
                'You get water reminders every [x] hours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 344,
              child: Text(
                'You get food reminders every [x] hours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 291,
              height: 36,
              child: Text(
                'Change Reminder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
             child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
              TextFormField(
                controller: _waterReminderController,
                decoration: const InputDecoration(
                  labelText: 'Remind water every ___(hours)',
                ),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter a reminder interval'
                            : null,
              ),
                    const SizedBox(height: 10),
              TextFormField(
                controller: _foodReminderController,
                decoration: const InputDecoration(
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
 
                    } 
                  },
                  child: const Text('Change'),
                ),
              ),
            ],
          ),
        ),
            ),
            Container(
              width: 215,
              height: 65,
              decoration: ShapeDecoration(
                color: const Color(0xFF507E7F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
                        Container(
              width: 215,
              height: 65,
              decoration: ShapeDecoration(
                color: const Color(0xFF507E7F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 291,
              height: 36,
              child: Text(
                'Change ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Julius Sans One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


