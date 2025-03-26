import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.databaseService});
  final DatabaseServices databaseService;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text("Testing out the settings page"),
      ),
    );  
  }
}
