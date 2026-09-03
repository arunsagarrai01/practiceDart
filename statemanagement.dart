import 'dart:io';

class StateManager {
  int _counter = 0;

  // List of functions that listen for state changes
  final List<void Function(int)> _listeners = [];

  int get counter => _counter;

  // Add a listener
  void subscribe(void Function(int) listener) {
    _listeners.add(listener);
  }

  // Remove a listener
  void unsubscribe(void Function(int) listener) {
    _listeners.remove(listener);
  }

  // Change state
  void increment() {
    _counter++;
    _notify();
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      _notify();
    }
  }

  void reset() {
    _counter = 0;
    _notify();
  }

  // Notify all listeners
  void _notify() {
    for (var listener in _listeners) {
      listener(_counter);
    }
  }
}

// ---------------------------
// MAIN PROGRAM
// ---------------------------

void main() {
  final stateManager = StateManager();

  // Listener 1
  stateManager.subscribe((value) {
    print("State changed!");
    print("Current counter: $value");
  });

  while (true) {
    print("\n======================");
    print("   DART STATE MANAGER");
    print("======================");
    print("1. Increment");
    print("2. Decrement");
    print("3. Reset");
    print("4. Show State");
    print("5. Exit");
    print("======================");

    stdout.write("Enter your choice: ");
    String? input = stdin.readLineSync();

    switch (input) {
      case "1":
        stateManager.increment();
        break;

      case "2":
        stateManager.decrement();
        break;

      case "3":
        stateManager.reset();
        break;

      case "4":
        print("Current state: ${stateManager.counter}");
        break;

      case "5":
        print("Goodbye!");
        return;

      default:
        print("Invalid choice!");
    }
  }
}
