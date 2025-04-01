import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'app_colors.dart';
import 'user_state.dart';
import 'dart:async';

class RemindersSection extends StatefulWidget {
  final UserState userState;
  const RemindersSection({super.key, required this.userState});

  @override
  State<RemindersSection> createState() => _RemindersSectionState();
}

class _RemindersSectionState extends State<RemindersSection> {
  final DatabaseServices _dbService = DatabaseServices.instance;
  List<Reminder> _reminders = [];
  Timer? _waterTimer;
  Timer? _foodTimer;
  Timer? _countdownTimer;
  int? _waterSchedule;
  int? _foodSchedule;
  DateTime? _nextWaterReminder;
  DateTime? _nextFoodReminder;

  @override
  void initState() {
    super.initState();
    _loadReminders();
    _setupReminders();
  }

  @override
  void dispose() {
    _waterTimer?.cancel();
    _foodTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _setupReminders() async {
    // Get schedules
    _waterSchedule = await _dbService.getWaterSchedule(widget.userState.petId);
    _foodSchedule = await _dbService.getFoodSchedule(widget.userState.petId);

    // Cancel existing timers if any
    _waterTimer?.cancel();
    _foodTimer?.cancel();
    _countdownTimer?.cancel();

    // Set initial reminder times
    final now = DateTime.now();
    _nextWaterReminder = now.add(Duration(hours: _waterSchedule ?? 0));
    _nextFoodReminder = now.add(Duration(hours: _foodSchedule ?? 0));

    // Set up water reminder timer
    if (_waterSchedule != null) {
      _waterTimer = Timer.periodic(
        Duration(hours: _waterSchedule!),
        (timer) {
          _createWaterReminder();
          _nextWaterReminder = DateTime.now().add(Duration(hours: _waterSchedule!));
        },
      );
    }

    // Set up food reminder timer
    if (_foodSchedule != null) {
      _foodTimer = Timer.periodic(
        Duration(hours: _foodSchedule!),
        (timer) {
          _createFoodReminder();
          _nextFoodReminder = DateTime.now().add(Duration(hours: _foodSchedule!));
        },
      );
    }

    // Set up countdown timer
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_nextWaterReminder != null) {
            _nextWaterReminder = _nextWaterReminder!.subtract(const Duration(seconds: 1));
          }
          if (_nextFoodReminder != null) {
            _nextFoodReminder = _nextFoodReminder!.subtract(const Duration(seconds: 1));
          }
        });
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Future<void> _createWaterReminder() async {
    final now = DateTime.now();
    await _dbService.createReminder(
      widget.userState.petId!,
      'Water Reminder',
      now.toIso8601String(),
    );
    _loadReminders();
  }

  Future<void> _createFoodReminder() async {
    final now = DateTime.now();
    await _dbService.createReminder(
      widget.userState.petId!,
      'Food Reminder',
      now.toIso8601String(),
    );
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT id, reminderType, reminderTime FROM reminder
      WHERE petId IN (SELECT id FROM pet WHERE userId = ?)
      ORDER BY reminderTime DESC
      LIMIT 10
    ''', [widget.userState.petId]);

    final reminders = result.map((e) => Reminder.fromMap(e)).toList();

    setState(() {
      _reminders = reminders;
    });

    for (var r in reminders) {
      print("🔔 Reminder: ${r.type} at ${r.time}");
    }
  }

  Future<void> _deleteReminder(int id) async {
    await _dbService.deleteReminder(id);
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0, bottom: 12),
          child: Text(
            "Reminders",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        // Countdown timers
        if (_waterSchedule != null || _foodSchedule != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_waterSchedule != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.water_drop, size: 20),
                        const SizedBox(width: 8),
                        const Text("Next water reminder in: "),
                        Text(
                          _nextWaterReminder != null
                              ? _formatDuration(_nextWaterReminder!.difference(DateTime.now()))
                              : "Calculating...",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                if (_foodSchedule != null)
                  Row(
                    children: [
                      const Icon(Icons.restaurant, size: 20),
                      const SizedBox(width: 8),
                      const Text("Next food reminder in: "),
                      Text(
                        _nextFoodReminder != null
                            ? _formatDuration(_nextFoodReminder!.difference(DateTime.now()))
                            : "Calculating...",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        // Previous reminders
        const Text(
          "Previous Reminders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        _reminders.isEmpty
            ? const Text("No reminders yet.")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final r = _reminders[index];
                  final icon = r.type.toLowerCase().contains('food')
                      ? Icons.restaurant
                      : Icons.water_drop;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(icon, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(r.type, style: const TextStyle(fontSize: 16)),
                        ),
                        Text("Sent: ${r.time}", style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _deleteReminder(r.id),
                          child: const Icon(Icons.close, size: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ],
    );
  }
}

class Reminder {
  final int id;
  final String type;
  final String time;

  Reminder({
    required this.id,
    required this.type,
    required this.time,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      type: map['reminderType'],
      time: map['reminderTime'],
    );
  }
}

