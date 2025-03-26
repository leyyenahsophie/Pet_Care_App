import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {  
  //leyyenah's code
    final _formKey = GlobalKey<FormState>();
  final DatabaseServices _databaseService = DatabaseServices.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _petNameController.dispose();
    _reminderController.dispose();
    super.dispose();
  } 

    void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      String firstName = _firstNameController.text.trim();
      String petName = _petNameController.text.trim();
      int? reminderInterval = int.tryParse(_reminderController.text.trim());

      if (reminderInterval == null || reminderInterval <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid reminder interval')),
        );
        return;
      }

      // Add user to the database
      _databaseService.addLogin(username, password);
      _databaseService.addPet(petName, 0, reminderInterval);

      // Navigate to the main page
      Navigator.pushReplacementNamed(context, '/main');
    }
  }
  //leyyenah's code end [1]
  
  //leyyenah's code start [2]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter a username'
                            : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter a password'
                            : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your first name'
                            : null,
              ),
              TextFormField(
                controller: _petNameController,
                decoration: const InputDecoration(labelText: 'Pet Name'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your pet\'s name'
                            : null,
              ),
              TextFormField(
                controller: _reminderController,
                decoration: const InputDecoration(
                  labelText: 'Remind every (hours)',
                ),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter a reminder interval'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
