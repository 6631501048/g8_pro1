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
    } else {
      print("Invalid choice");
    }
  } while (choice != "6");
}

Future<void> showAllExpenses(int userId) async {
  final url = Uri.parse('http://localhost:3000/expenses/$userId');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List expenses = jsonDecode(response.body);
    if (expenses.isEmpty) {
      print("Notthing bruhh");
    } else {
      int total = 0;
      print("------------ All Expenses ------------");
      for (var exp in expenses) {
        print(
          " ${exp['id']}. ${exp['items']} : ${exp['paid']}฿ :${exp['date']}",
        );
        total += (exp['paid'] as num).toInt();
      }
      print("Total expense: ${total}฿ ");
    }
  } else {
    print("Error fetching expenses: ${response.body}");
  }
}

Future<void> showTodayExpenses(int userId) async {
  final url = Uri.parse('http://localhost:3000/expenses/today/$userId');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List expenses = jsonDecode(response.body);
    if (expenses.isEmpty) {
      print("Notthing for today");
    } else {
      print("------------ Today's Expenses ------------");
      int total = 0;
      for (var exp in expenses) {
        print(
          " ${exp['id']}. ${exp['items']} : ${exp['paid']}฿ :${exp['date']}",
        );
        total += (exp['paid'] as num).toInt();
      }
      print("Total expenses: ${total}฿ ");
    }
  } else {
    print("Error fetching today's expenses: ${response.body}");
  }
}
//fea 3

//fea 4

//fea 5+6
