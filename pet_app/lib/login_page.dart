import 'package:flutter/material.dart';
import 'package:pet_app/app_colors.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'register_page.dart';
import 'user_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseServices _databaseService = DatabaseServices.instance;
  final UserState _localStorage = UserState();

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.all(16);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF507E7F),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: padding,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 25,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Username'),  
                        ),
                        onSaved: (value) => username = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLength: 25,
                        maxLines: 1,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Password'),
                        ),
                        onSaved: (value) => password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: padding,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final userId = await _databaseService.verifyLogin(username!, password!);
                        
                        if (userId != null) {
                          final petId = await _databaseService.getPetId(userId);
                          
                          _localStorage.userId = userId;
                          _localStorage.username = username;
                          _localStorage.petId = petId;
                          _localStorage.petName = await _databaseService.getPetName(userId, petId);
                          _localStorage.firstName = await _databaseService.getFirstName(userId);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(title: 'Pet Care App', credentials:_localStorage),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid username or password')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all fields')),
                        );
                      }
                    },
                    child: const Text('Log In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}