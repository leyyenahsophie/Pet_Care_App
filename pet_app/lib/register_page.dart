import 'package:flutter/material.dart';
import 'package:pet_app/database_services.dart';
import 'app_colors.dart';
import 'user_state.dart';
import 'login_page.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseServices _databaseService = DatabaseServices.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _waterScheduleController = TextEditingController();
  final TextEditingController _foodScheduleController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _petNameController.dispose();
    _waterScheduleController.dispose();
    _foodScheduleController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      String firstName = _firstNameController.text.trim();
      String petName = _petNameController.text.trim();
      int? waterSchedule = int.tryParse(_waterScheduleController.text.trim());
      int? foodSchedule = int.tryParse(_foodScheduleController.text.trim());

      if (waterSchedule == null || waterSchedule <= 0 || foodSchedule == null || foodSchedule <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter valid schedule values')),
        );
        return;
      }

      // Check if username is already taken
      bool isTaken = await _databaseService.isUsernameTaken(username);
      if (isTaken) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username is already taken')),
          );
        }
        return;
      }

      UserState localStorage = UserState();

      try {
        final userId = await _databaseService.addLogin(username, password, firstName);
        final petId = await _databaseService.addPet(petName, waterSchedule, foodSchedule, userId);

        localStorage.petName = petName;
        localStorage.username = username;
        localStorage.firstName = firstName;
        localStorage.userId = userId;
        localStorage.petId = petId;

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(title: 'Pet Care App', credentials: localStorage),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error during registration: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a username' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty ? 'Enter a password' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your first name' : null,
              ),
              TextFormField(
                controller: _petNameController,
                decoration: const InputDecoration(labelText: 'Pet Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your pet\'s name' : null,
              ),
              TextFormField(
                controller: _waterScheduleController,
                decoration: const InputDecoration(labelText: 'Water every (hours)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter water schedule' : null,
              ),
              TextFormField(
                controller: _foodScheduleController,
                decoration: const InputDecoration(labelText: 'Feed every (hours)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter food schedule' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Register'),
              ),
              TextButton(
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
