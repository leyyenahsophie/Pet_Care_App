import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'log_history_page.dart';

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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Positioned(
                left: 19,
                top: 75,
                child: SizedBox(
                  width: 585,
                  height: 70,
                  child: Text(
                    'Hey, First Name ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 138,
                top: 225,
                child: SizedBox(
                  width: 115,
                  height: 35,
                  child: Text(
                    'Water Log',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 148,
                top: 264,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Date & Time of Log',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 731,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'petName is getting hungry',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 782,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Make sure petName is hydrated',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 279,
                top: 687,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'time for some nourishment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 547,
                top: 687,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Sent: 00/00/00 00:00 AM',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 547,
                top: 731,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Sent: 00/00/00 00:00 AM',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 547,
                top: 777,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Sent: 00/00/00 00:00 AM',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 425,
                top: 264,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Log description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 425,
                top: 445,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Log description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 148,
                top: 445,
                child: SizedBox(
                  width: 211,
                  height: 35,
                  child: Text(
                    'Date & Time of Log',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 134,
                top: 402,
                child: SizedBox(
                  width: 115,
                  height: 35,
                  child: Text(
                    'Food Log',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 595,
                child: Container(
                  width: 710,
                  height: 222,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF507E7F),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 210,
                child: Container(
                  width: 756,
                  height: 158,
                  decoration: ShapeDecoration(
                    color: const Color(0x00507E7F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF507E7F),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 387,
                child: Container(
                  width: 756,
                  height: 158,
                  decoration: ShapeDecoration(
                    color: const Color(0x00507E7F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF507E7F),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 718,
                top: 462,
                child: Container(
                  width: 134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF7B2D26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 718,
                top: 289,
                child: Container(
                  width: 134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF804E49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 696,
                top: 466,
                child: SizedBox(
                  width: 177,
                  height: 70,
                  child: Text(
                    'Log',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 696,
                top: 292,
                child: SizedBox(
                  width: 177,
                  height: 70,
                  child: Text(
                    'Log',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 198,
                top: 595,
                child: SizedBox(
                  width: 585,
                  height: 70,
                  child: Text(
                    'Reminders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64,
                      fontFamily: 'Judson',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 138,
                top: 281,
                child: Container(
                  width: 243,
                  height: 56,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 138,
                top: 462,
                child: Container(
                  width: 243,
                  height: 56,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 409,
                top: 281,
                child: Container(
                  width: 243,
                  height: 56,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 409,
                top: 462,
                child: Container(
                  width: 243,
                  height: 56,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 223,
                top: 675,
                child: Container(
                  width: 534,
                  height: 37,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 223,
                top: 722,
                child: Container(
                  width: 534,
                  height: 37,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 223,
                top: 769,
                child: Container(
                  width: 534,
                  height: 37,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 730,
                top: 687,
                child: Container(
                  width: 16,
                  height: 16,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 730,
                top: 732,
                child: Container(
                  width: 16,
                  height: 16,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 730,
                top: 782,
                child: Container(
                  width: 16,
                  height: 16,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 39,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/39x41"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 31,
                  height: 27,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/31x27"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
