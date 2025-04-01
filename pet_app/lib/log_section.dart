import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'log_history_page.dart';
import 'user_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LogSection extends StatefulWidget {
  const LogSection({super.key, required this.userState});
  final UserState userState;

  @override
  State<LogSection> createState() => _LogSectionState();
}

class _LogSectionState extends State<LogSection> {
  final DatabaseServices _databaseService = DatabaseServices.instance;

  final _waterLogFormKey = GlobalKey<FormState>();
  final _foodLogFormKey = GlobalKey<FormState>();

  final TextEditingController _waterLogController = TextEditingController();
  final TextEditingController _waterLogDateController = TextEditingController();
  final TextEditingController _foodLogController = TextEditingController();
  final TextEditingController _foodLogDateController = TextEditingController();

  void _logWater() {
    String logDescription = _waterLogController.text;
    setState(() {
      _databaseService.logWater(widget.userState.petId!, logDescription);
      _waterLogController.clear();
      _waterLogDateController.clear();
    });
  }

  void _logFood() {
    String logDescription = _foodLogController.text;
    setState(() {
      _databaseService.logFood(widget.userState.petId!, logDescription);  
      _foodLogController.clear();
      _foodLogDateController.clear();
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Water Log Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0x00507E7F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF507E7F)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Water Log',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _waterLogFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            format: DateFormat('yyyy-MM-dd'),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date & Time of Water Log',
                            ),
                            controller: _waterLogDateController,
                            validator:
                                (value) =>
                                    value == null
                                        ? 'must enter date and time'
                                        : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Log description',
                              border: OutlineInputBorder(),
                            ),
                            controller: _waterLogController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_waterLogFormKey.currentState!.validate()) {
                        // _waterLogFormKey.currentState!.save();
                        _logWater();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Water logged successfully'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF804E49),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Log',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Food Log Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0x00507E7F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF507E7F)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Log',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _foodLogFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            format: DateFormat('yyyy-MM-dd'),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date & Time of Food Log',
                            ),
                            controller: _foodLogDateController,
                            validator: (value) => value == null ? 'must enter date and time' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Log description',
                              border: OutlineInputBorder(),
                            ),
                            controller: _foodLogController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_foodLogFormKey.currentState!.validate()) {
                        // _foodLogFormKey.currentState!.save();
                        _logFood();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feeding logged successfully'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B2D26),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Log',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/**
 * Create a water log section 
 * Create a food log section
 * Each section will have an icon, a title, and a form asking for the date/time and the description of the log, button to log the item
 * 
 * 
 */
