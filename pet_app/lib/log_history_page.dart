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
  List<Map<String, dynamic>> _logs = [];

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    final db = await _databaseService.database;
    final result = await db.query('log');
    setState(() {
      _logs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          child: Text('Log History'),
        ),
      ),
    );
  }
}