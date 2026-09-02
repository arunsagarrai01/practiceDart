import 'dart:io';

class Book {
  String title;
  String author;
  bool isBorrowed;

  Book(this.title, this.author, {this.isBorrowed = false});

  void display() {
    String status = isBorrowed ? 'Borrowed' : 'Available';

    print('$title by $author [$status]');
  }
}

void main() {
  List<Book> books = [
    Book('The Alchemist', 'Paulo Coelho'),
    Book('Clean Code', 'Robert Martin'),
    Book('Dart Programming', 'John Smith'),
  ];

  while (true) {
    print('\n===== LIBRARY SYSTEM =====');
    print('1. View Books');
    print('2. Borrow Book');
    print('3. Return Book');
    print('4. Exit');

    stdout.write('Choose option: ');
    int choice = int.parse(stdin.readLineSync()!);

    if (choice == 1) {
      print('\n===== BOOKS =====');

      for (Book book in books) {
        book.display();
      }
    } else if (choice == 2) {
      stdout.write('Enter book title: ');
      String title = stdin.readLineSync()!;

      bool found = false;

      for (Book book in books) {
        if (book.title.toLowerCase() == title.toLowerCase()) {
          found = true;

          if (book.isBorrowed) {
            print('This book is already borrowed.');
          } else {
            book.isBorrowed = true;
            print('Book borrowed successfully.');
          }
        }
      }

      if (!found) {
        print('Book not found.');
      }
    } else if (choice == 3) {
      stdout.write('Enter book title: ');
      String title = stdin.readLineSync()!;

      bool found = false;

      for (Book book in books) {
        if (book.title.toLowerCase() == title.toLowerCase()) {
          found = true;

          if (!book.isBorrowed) {
            print('This book was not borrowed.');
          } else {
            book.isBorrowed = false;
            print('Book returned successfully.');
          }
        }
      }

      if (!found) {
        print('Book not found.');
      }
    } else if (choice == 4) {
      print('Library system closed.');
      return;
    } else {
      print('Invalid option.');
    }
  }
}
