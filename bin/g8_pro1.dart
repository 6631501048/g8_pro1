import 'package:g8_pro1/g8_pro1.dart' as g8_pro1;
import 'package:http/http.dart' as http;
import 'dart:io';

import 'dart:convert';

//fea 1+2

//fea 3

//fea 4

//fea 5+6
Future<void> deleteExpense(int userId) async {
  print("==== Delete an item ====");
  stdout.write("Item id: ");
  String? idInput = stdin.readLineSync();
  if (idInput == null || idInput.isEmpty) {
    print("Invalid ID.");
    return;
  }

  final url = Uri.parse('http://localhost:3000/expenses/$userId/$idInput');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print("deleted");
  } else if (response.statusCode == 404) {
    print("Expense not found.");
  } else {
    print("❌ Error deleting expense: ${response.body}");
  }
}

void exitApp() {
  print("---------- Bye ----------");
  exit(0); // off program
}