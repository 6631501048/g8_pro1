import 'package:g8_pro1/g8_pro1.dart' as g8_pro1;
import 'package:http/http.dart' as http;
import 'dart:io';

import 'dart:convert';

//fea 1+2
void main() async {
  await login();
}

Future<void> login() async {
  print("===== Login =====");
  // Get username and password
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();
  if (username == null || password == null) {
    print("Incomplete input");
    return;
  }
  final body = {"username": username, "password": password};
  final url = Uri.parse('http://localhost:3000/login');
  final response = await http.post(url, body: body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final userId = data['userId'];
    print("Login OK!");
    await showmenu(userId);
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    final result = response.body;
    print(result);
  } else {
    print("Unknown error");
  }
}

Future<void> showmenu(int userId) async {
  String? choice;
  do {
    print("======= Expense tracking app =======");
    print("1.all expenses");
    print("2.Today's expenses");
    print("3.Search expenses");
    print("4.Add new expense");
    print("5.Delete anexpense");
    print("6. Exit");
    stdout.write("Choose... ");
    choice = stdin.readLineSync();
     if (choice == "1") {
      await showAllExpenses(userId);
    } else if (choice == "2") {
      await showTodayExpenses(userId);
    } else if (choice == "3") {
      await searchExpenses(userId);
      }else if (choice == "4"){
      await addExpense(userId);
      }else if (choice == "5") {
      await deleteExpense(userId);
    } else if (choice != "6") {
      print("Invalid choice");
    }
  } while (choice != "6");
}
//fea 3

//fea 4
Future<void> addExpense(int userId) async {
  stdout.write("Item: ");
  String? item = stdin.readLineSync()?.trim();
  stdout.write("Paid amount: ");
  String? paidStr = stdin.readLineSync()?.trim();
  int? paid = int.tryParse(paidStr ?? "");

  if (item == null || item.isEmpty || paid == null) {
    print("Invalid input.");
    return;
  }

  final body = {"items": item, "paid": paid.toString(), "userId": userId.toString()};
  final url = Uri.parse('http://localhost:3000/expenses/add');
  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    print("Expense added successfully!");
  } else {
    print("Error: ${response.body}");
  }
}
//fea 5+6
