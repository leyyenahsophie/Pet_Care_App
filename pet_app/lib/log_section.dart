import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class LogSection extends StatefulWidget {
  const LogSection({super.key});

  @override
  State<LogSection> createState() => _LogSectionState();
}

  class _LogSectionState extends State<LogSection> {  
  final DatabaseServices _databaseService = DatabaseServices.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log'),
      ),
    );
  }
}
