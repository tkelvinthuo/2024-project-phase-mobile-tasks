import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  // Constructor
  Product({
    required String name,
    required String description,
    required double price,
  })  : _name = name,
        _description = description,
        _price = price;

  // --- Getters ---
  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String value) {
    if (value.isNotEmpty) {
      _name = value;
    } else {
      print('Name cannot be empty.');
    }
  }

  set description(String value) {
    if (value.isNotEmpty) {
      _description = value;
    } else {
      print('Description cannot be empty.');
    }
  }

  set price(double value) {
    if (value >= 0) {
      _price = value;
    } else {
      print('Price must be positive.');
    }
  }

  void display() {
    print('Name: $_name');
    print('Description: $_description');
    print('Price: \$${_price.toStringAsFixed(2)}');
  }
}

class ProductManager {
  final List<Product> _products = [];

  // Add new product
  void addProduct(Product product) {
    _products.add(product);
    print('\nProduct "${product.name}" added successfully!\n');
  }

  // View all products
  void viewAllProducts() {
    if (_products.isEmpty) {
      print('\nNo products available.\n');
      return;
    }

    print('\nProduct List:');
    for (int i = 0; i < _products.length; i++) {
      print('\nProduct #${i + 1}');
      _products[i].display();
    }
  }

  // View single product
  void viewProduct(int index) {
    if (_isInvalidIndex(index)) return;
    print('\n🔍 Product Details:');
    _products[index].display();
  }

  // Edit product
  void editProduct(int index, {String? name, String? description, double? price}) {
    if (_isInvalidIndex(index)) return;
    final product = _products[index];

    if (name != null && name.isNotEmpty) product.name = name;
    if (description != null && description.isNotEmpty) product.description = description;
    if (price != null) product.price = price;

    print('\nProduct updated successfully!\n');
  }

  // Delete product
  void deleteProduct(int index) {
    if (_isInvalidIndex(index)) return;
    final removed = _products.removeAt(index);
    print('\nProduct "${removed.name}" deleted successfully!\n');
  }

  // Private helper to handle invalid indices
  bool _isInvalidIndex(int index) {
    if (index < 0 || index >= _products.length) {
      print('\nInvalid product index.\n');
      return true;
    }
    return false;
  }
}


void main() {
  final manager = ProductManager();

  while (true) {
    print('''
============================
Dart eCommerce Application
============================
1. Add Product
2. View All Products
3. View Product by Index
4. Edit Product
5. Delete Product
6. Exit
----------------------------
Enter your choice:
''');

    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        final name = stdin.readLineSync() ?? '';

        stdout.write('Enter description: ');
        final description = stdin.readLineSync() ?? '';

        stdout.write('Enter price: ');
        final priceInput = stdin.readLineSync();
        final price = double.tryParse(priceInput ?? '') ?? -1;

        if (price < 0) {
          print('\nInvalid price entered.\n');
          break;
        }

        manager.addProduct(Product(name: name, description: description, price: price));
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter product index (starting from 1): ');
        final indexInput = stdin.readLineSync();
        final index = int.tryParse(indexInput ?? '') ?? 0;
        manager.viewProduct(index - 1);
        break;

      case '4':
        stdout.write('Enter product index (starting from 1): ');
        final editIndexInput = stdin.readLineSync();
        final editIndex = int.tryParse(editIndexInput ?? '') ?? 0;

        stdout.write('Enter new name (leave blank to keep current): ');
        final newName = stdin.readLineSync();
        stdout.write('Enter new description (leave blank to keep current): ');
        final newDescription = stdin.readLineSync();
        stdout.write('Enter new price (leave blank to keep current): ');
        final newPriceInput = stdin.readLineSync();

        final newPrice = newPriceInput != null && newPriceInput.isNotEmpty
            ? double.tryParse(newPriceInput)
            : null;

        manager.editProduct(
          editIndex - 1,
          name: (newName != null && newName.isNotEmpty) ? newName : null,
          description: (newDescription != null && newDescription.isNotEmpty) ? newDescription : null,
          price: newPrice,
        );
        break;

      case '5':
        stdout.write('Enter product index (starting from 1): ');
        final deleteIndexInput = stdin.readLineSync();
        final deleteIndex = int.tryParse(deleteIndexInput ?? '') ?? 0;
        manager.deleteProduct(deleteIndex - 1);
        break;

      case '6':
        print('\nExiting application. Goodbye!\n');
        return;

      default:
        print('\nInvalid choice. Please try again.\n');
    }
  }
}
