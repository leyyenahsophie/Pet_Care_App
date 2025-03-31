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
          width: 851,
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          padding: const EdgeInsets.all(24),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(
                width: 1,
                color: Colors.black12,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Log History",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF507E7F),
                ),
              ),
              const SizedBox(height: 24),
              _logs.isEmpty
                  ? const Text("No logs available.")
                  : DataTable(
                      columns: const [
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Type")),
                        DataColumn(label: Text("Description")),
                      ],
                      rows: _logs.map((log) {
                        return DataRow(
                          cells: [
                            DataCell(Text(log['logDate'].toString())),
                            DataCell(Text(log['logType'].toString())),
                            DataCell(Text(log['logDescription'].toString())),
                          ],
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}