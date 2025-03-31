import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:pet_app/log_history_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'log_history_page.dart';
import 'settings_page.dart';
import 'pet_guide_page.dart';
import 'app_colors.dart';
import 'user_state.dart';

void main() {
  // Initialize FFI for sqflite
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userState = UserState();

    return MaterialApp(
      title: 'Pet Care App',
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/main': (context) => MainPage(title: 'Pet Care App', credentials: userState),
      },
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainPage(title: 'Pet App Main Page', credentials: userState),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title,required this.credentials});
  //create required variables, credentials 
  final String title;
  final UserState credentials;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //create instance of database service
  final DatabaseServices _databaseService = DatabaseServices.instance;


  //use these variables for page control
  int currentPageIndex = 0;
  late PageController _pageController;

  @override

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final int? petId = widget.credentials.petId;
  final int? userId = widget.credentials.userId;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Pet Care App"),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            children: [
              //container for the main page
              Container(color: AppColors.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    //button for registration
                    ElevatedButton(
                      onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  RegisterPage())),
                      child: const Text('Register'),
                    ),
                    FutureBuilder<String?>(
                      future: _databaseService.getFirstName(userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data ?? 'No name found');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
                ),
              //container for the pet guide
              Container(color: AppColors.background,
              child: Center(
                child: PetGuidePage(),
              ),
              ),
              Container(color: AppColors.background,
              child: Center(
                child: LogHistoryPage(userId: userId!),
              ),
              ),
              //container for the settings page
              Container(color: AppColors.background,
              child: Center(
                child: SettingsPage(databaseService: _databaseService, credentials: widget.credentials),
              ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentPageIndex,
          onItemSelected: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              activeColor: AppColors.accent1,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.pets),
              title: Text("Pet Guide"),
              activeColor: AppColors.accent1,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.history),
              title: Text("Log History"),
              activeColor: AppColors.accent1,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              activeColor: AppColors.accent1,
            ),
          ],
        ),
        ),
    );
  }
}
