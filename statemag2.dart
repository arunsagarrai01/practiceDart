import 'dart:io';

// product class

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

// cart item class

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

// sate manager

class CartStateManager {
  final List<CartItem> _cart = [];

  // Listeners
  final List<void Function()> _listeners = [];

  // Get cart
  List<CartItem> get cart => List.unmodifiable(_cart);

  // Calculate total items
  int get totalItems {
    int total = 0;

    for (var item in _cart) {
      total += item.quantity;
    }

    return total;
  }

  // Calculate total price
  double get totalPrice {
    double total = 0;

    for (var item in _cart) {
      total += item.totalPrice;
    }

    return total;
  }

  // Subscribe listener
  void subscribe(void Function() listener) {
    _listeners.add(listener);
  }

  // Notify listeners
  void _notify() {
    for (var listener in _listeners) {
      listener();
    }
  }

  // Add product
  void addProduct(Product product) {
    for (var item in _cart) {
      if (item.product.name == product.name) {
        item.quantity++;
        _notify();
        return;
      }
    }

    _cart.add(CartItem(product: product));

    _notify();
  }

  // Remove product
  void removeProduct(String productName) {
    _cart.removeWhere((item) => item.product.name == productName);

    _notify();
  }

  // Increase quantity
  void increaseQuantity(String productName) {
    for (var item in _cart) {
      if (item.product.name == productName) {
        item.quantity++;
        break;
      }
    }

    _notify();
  }

  // Decrease quantity
  void decreaseQuantity(String productName) {
    for (var item in _cart) {
      if (item.product.name == productName) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _cart.remove(item);
        }

        break;
      }
    }

    _notify();
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    _notify();
  }
}

// display cart function

void displayCart(CartStateManager cartManager) {
  print("\n==============================");
  print("          SHOPPING CART");
  print("==============================");

  if (cartManager.cart.isEmpty) {
    print("Cart is empty.");
  } else {
    for (var item in cartManager.cart) {
      print(
        "${item.product.name} "
        "x${item.quantity} "
        "= Rs. ${item.totalPrice.toStringAsFixed(2)}",
      );
    }
  }

  print("------------------------------");
  print("Total items: ${cartManager.totalItems}");
  print("Total price: Rs. ${cartManager.totalPrice.toStringAsFixed(2)}");
  print("==============================");
}

// ---------------------------
// MAIN
// ---------------------------

void main() {
  // Create products
  final laptop = Product(name: "Laptop", price: 80000);

  final phone = Product(name: "Phone", price: 30000);

  final headphones = Product(name: "Headphones", price: 5000);

  // Create state manager
  final cartManager = CartStateManager();

  // Listen for state changes
  cartManager.subscribe(() {
    print("\nCart state updated!");
  });

  while (true) {
    print("\n==============================");
    print("       ONLINE SHOP");
    print("==============================");
    print("1. Add Laptop");
    print("2. Add Phone");
    print("3. Add Headphones");
    print("4. View Cart");
    print("5. Increase Quantity");
    print("6. Decrease Quantity");
    print("7. Remove Product");
    print("8. Clear Cart");
    print("9. Exit");
    print("==============================");

    stdout.write("Enter choice: ");

    final choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        cartManager.addProduct(laptop);
        break;

      case "2":
        cartManager.addProduct(phone);
        break;

      case "3":
        cartManager.addProduct(headphones);
        break;

      case "4":
        displayCart(cartManager);
        break;

      case "5":
        stdout.write("Enter product name: ");

        final name = stdin.readLineSync();

        if (name != null) {
          cartManager.increaseQuantity(name);
        }

        break;

      case "6":
        stdout.write("Enter product name: ");

        final name = stdin.readLineSync();

        if (name != null) {
          cartManager.decreaseQuantity(name);
        }

        break;

      case "7":
        stdout.write("Enter product name: ");

        final name = stdin.readLineSync();

        if (name != null) {
          cartManager.removeProduct(name);
        }

        break;

      case "8":
        cartManager.clearCart();
        print("Cart cleared!");
        break;

      case "9":
        print("Thank you for shopping!");
        return;

      default:
        print("Invalid choice!");
    }
  }
}
