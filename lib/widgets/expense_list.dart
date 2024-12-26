// widgets/expense_list.dart
import 'package:budget_planner_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner_app/models/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseListScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense List'),
        backgroundColor: AppColors.charcoal,
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.category),
            subtitle:
                Text('Amount: \$${expense.amount}, Date: ${expense.date}'),
          );
        },
      ),
    );
  }
}
