import 'package:g8_pro1/g8_pro1.dart' as g8_pro1;
import 'package:http/http.dart' as http;
import 'dart:io';

import 'dart:convert';

//fea 1+2

//fea 3
Future<void> searchExpenses(int userId) async {
  stdout.write("Item to search: ");
  String? keyword = stdin.readLineSync()?.trim();
  if (keyword == null || keyword.isEmpty) {
    print("No keyword entered.");
    return;
  }
  final url = Uri.parse('http://localhost:3000/expenses/search/$userId?keyword=$keyword');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List expenses = jsonDecode(response.body);
    if (expenses.isEmpty) {
      print("No item '$keyword'.");
    } else {
      print("------ Search Results -----");
      for (var exp in expenses) {
        print(" ${exp['id']}. ${exp['items']} : ${exp['paid']}฿ :${exp['date']}");
      }
    }
  } else {
    print("Error searching expenses: ${response.body}");
  }
}

//fea 4

//fea 5+6
