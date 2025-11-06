import 'dart:io';

// Represents a single product
class Product {
  String name;
  String description;
  double price;

  Product({
    required this.name,
    required this.description,
    required this.price,
  });

  void display() {
    print('Name: $name');
    print('Description: $description');
    print('Price: \$${price.toStringAsFixed(2)}');
  }
}

// Manages a list of products (CRUD operations)
class ProductManager {
  final List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print('\n✅ Product "${product.name}" added successfully!\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('\n⚠️ No products found.\n');
      return;
    }
    print('\n🛍️ Product List:');
    for (int i = 0; i < _products.length; i++) {
      print('\nProduct #${i + 1}');
      _products[i].display();
    }
  }

  void viewProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('\n⚠️ Invalid product index.\n');
      return;
    }
    print('\n🔍 Product Details:');
    _products[index].display();
  }

  void editProduct(int index, {String? name, String? description, double? price}) {
    if (index < 0 || index >= _products.length) {
      print('\n⚠️ Invalid product index.\n');
      return;
    }
    final product = _products[index];
    if (name != null) product.name = name;
    if (description != null) product.description = description;
    if (price != null) product.price = price;

    print('\n✏️ Product updated successfully!\n');
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('\n⚠️ Invalid product index.\n');
      return;
    }
    final removed = _products.removeAt(index);
    print('\n🗑️ Product "${removed.name}" deleted successfully!\n');
  }
}

// Main function with CLI interface
void main() {
  final manager = ProductManager();

  while (true) {
    print('''
============================
🛒 Dart eCommerce Application
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
        final price = double.tryParse(priceInput ?? '') ?? 0.0;

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
          name: newName!.isEmpty ? null : newName,
          description: newDescription!.isEmpty ? null : newDescription,
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
        print('\n👋 Exiting application. Goodbye!\n');
        return;

      default:
        print('\n⚠️ Invalid choice. Please try again.\n');
    }
  }
}
