import 'dart:io';

class Contact {
  String name;
  String phone;

  Contact(this.name, this.phone);

  void display() {
    print('Name: $name | Phone: $phone');
  }
}

void main() {
  List<Contact> contacts = [];

  while (true) {
    print('\n===== CONTACT MANAGEMENT =====');
    print('1. Add Contact');
    print('2. View Contacts');
    print('3. Search Contact');
    print('4. Delete Contact');
    print('5. Exit');

    stdout.write('Choose option: ');
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write('Enter name: ');
        String name = stdin.readLineSync()!;

        stdout.write('Enter phone number: ');
        String phone = stdin.readLineSync()!;

        contacts.add(Contact(name, phone));

        print('Contact added successfully.');
        break;

      case 2:
        if (contacts.isEmpty) {
          print('No contacts found.');
        } else {
          print('\n===== CONTACTS =====');

          for (Contact contact in contacts) {
            contact.display();
          }
        }
        break;

      case 3:
        stdout.write('Enter name to search: ');
        String search = stdin.readLineSync()!;

        bool found = false;

        for (Contact contact in contacts) {
          if (contact.name.toLowerCase() == search.toLowerCase()) {
            contact.display();
            found = true;
          }
        }

        if (!found) {
          print('Contact not found.');
        }

        break;

      case 4:
        stdout.write('Enter name to delete: ');
        String name = stdin.readLineSync()!;

        contacts.removeWhere(
          (contact) => contact.name.toLowerCase() == name.toLowerCase(),
        );

        print('Contact deleted if it existed.');
        break;

      case 5:
        print('Goodbye!');
        return;

      default:
        print('Invalid option.');
    }
  }
}
