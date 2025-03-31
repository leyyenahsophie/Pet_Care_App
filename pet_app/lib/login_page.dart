import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}