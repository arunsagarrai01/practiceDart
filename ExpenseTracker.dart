import 'dart:io';

class Expense {
  String category;
  double amount;

  Expense(this.category, this.amount);

  void display() {
    print('$category: Rs. ${amount.toStringAsFixed(2)}');
  }
}

void main() {
  List<Expense> expenses = [];

  while (true) {
    print('\n===== EXPENSE TRACKER =====');
    print('1. Add Expense');
    print('2. View Expenses');
    print('3. Show Total');
    print('4. Show Highest Expense');
    print('5. Exit');

    stdout.write('Choose option: ');
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write('Enter category: ');
        String category = stdin.readLineSync()!;

        stdout.write('Enter amount: ');
        double amount = double.parse(stdin.readLineSync()!);

        expenses.add(Expense(category, amount));

        print('Expense added.');
        break;

      case 2:
        if (expenses.isEmpty) {
          print('No expenses recorded.');
        } else {
          print('\n===== EXPENSES =====');

          for (Expense expense in expenses) {
            expense.display();
          }
        }
        break;

      case 3:
        double total = 0;

        for (Expense expense in expenses) {
          total += expense.amount;
        }

        print('Total Expenses: Rs. ${total.toStringAsFixed(2)}');
        break;

      case 4:
        if (expenses.isEmpty) {
          print('No expenses available.');
        } else {
          Expense highest = expenses[0];

          for (Expense expense in expenses) {
            if (expense.amount > highest.amount) {
              highest = expense;
            }
          }

          print('Highest Expense:');
          highest.display();
        }
        break;

      case 5:
        print('Expense tracker closed.');
        return;

      default:
        print('Invalid option.');
    }
  }
}
