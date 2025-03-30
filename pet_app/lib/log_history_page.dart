import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'login_page.dart';

class LogHistoryPage extends StatefulWidget {
  const LogHistoryPage({super.key});

  @override
  State<LogHistoryPage> createState() => _LogHistoryPageState();
}

class _LogHistoryPageState extends State<LogHistoryPage> {  
  final DatabaseServices _databaseService = DatabaseServices.instance;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Text("Log History"),
      ),
    );
  }
}
