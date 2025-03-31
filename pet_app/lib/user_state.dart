class UserState {
  static final UserState _instance = UserState._internal();
  factory UserState() => _instance;
  UserState._internal();

  int? userId;
  String? username;
  String? petName;
  String? firstName;
  int? petId;
} 