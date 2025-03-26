import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'settings_page.dart';
import 'pet_guide_page.dart';
import 'app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care App',
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MainPage(title: 'Pet Care App'),
      },
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(title: 'Pet App Main Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //create instance of database service
  final DatabaseServices _databaseService = DatabaseServices.instance;

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
              Container(color: AppColors.background,
              child: Center(
                        child: ElevatedButton(
        onPressed: () => Navigator.push(context,
         MaterialPageRoute(builder: (context) =>  RegisterPage())),
         child: const Text('Register'),),
              ),
                ),
              Container(color: AppColors.background,
              child: Center(
                child: PetGuidePage(),
              ),
              ),
              Container(color: AppColors.background,
              child: Center(
                child: SettingsPage(databaseService: _databaseService),
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
