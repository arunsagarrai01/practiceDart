import 'dart:io';

// AUTH STATUS

enum AuthStatus { loggedOut, loading, loggedIn }

// USER MODEL

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

// AUTH STATE

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState({required this.status, this.user, this.errorMessage});
}

// AUTH STATE MANAGER

class AuthStateManager {
  AuthState _state = AuthState(status: AuthStatus.loggedOut);

  final List<void Function(AuthState)> _listeners = [];

  // Get current state
  AuthState get state => _state;

  // Subscribe to state changes
  void subscribe(void Function(AuthState) listener) {
    _listeners.add(listener);
  }

  // Notify listeners
  void _notify() {
    for (var listener in _listeners) {
      listener(_state);
    }
  }

  // LOGIN

  void login(String email, String password) {
    // Change state to loading
    _state = AuthState(status: AuthStatus.loading);

    _notify();

    // Simple fake login
    if (email == "admin@gmail.com" && password == "123456") {
      final user = User(name: "Admin", email: email);

      _state = AuthState(status: AuthStatus.loggedIn, user: user);
    } else {
      _state = AuthState(
        status: AuthStatus.loggedOut,
        errorMessage: "Invalid email or password!",
      );
    }

    _notify();
  }

  // LOGOUT

  void logout() {
    _state = AuthState(status: AuthStatus.loggedOut);

    _notify();
  }
}

// DISPLAY STATE

void displayState(AuthState state) {
  switch (state.status) {
    case AuthStatus.loggedOut:
      print("STATUS: Logged Out");

      if (state.errorMessage != null) {
        print("ERROR: ${state.errorMessage}");
      }

      break;

    case AuthStatus.loading:
      print("STATUS: Logging in...");
      break;

    case AuthStatus.loggedIn:
      print("STATUS: Logged In");
      print("Name: ${state.user!.name}");
      print("Email: ${state.user!.email}");
      break;
  }
}

// MAIN

void main() {
  final authManager = AuthStateManager();

  // Listen to state changes
  authManager.subscribe((state) {
    displayState(state);
  });

  while (true) {
    print("AUTH STATE MANAGER");

    print("1. Login");
    print("2. Show Current State");
    print("3. Logout");
    print("4. Exit");

    stdout.write("Enter choice: ");
    final choice = stdin.readLineSync();

    switch (choice) {
      //login

      case "1":
        stdout.write("Enter email: ");
        final email = stdin.readLineSync();

        stdout.write("Enter password: ");
        final password = stdin.readLineSync();

        if (email != null && password != null) {
          authManager.login(email, password);
        }

        break;

      // show state

      case "2":
        displayState(authManager.state);
        break;

      //logout

      case "3":
        authManager.logout();
        break;

      //exit

      case "4":
        print("Program closed.");
        return;

      default:
        print("Invalid choice!");
    }
  }
}
