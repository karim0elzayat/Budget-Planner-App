import 'package:budget_planner_app/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_planner_app/widgets/expense_list.dart';
import 'package:budget_planner_app/utils/app_colors.dart';

class ExpenseCategoryScreen extends StatelessWidget {
  const ExpenseCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses by Category'),
        backgroundColor: AppColors.charcoal,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;

            // Adjust padding and font size based on screen size
            double padding = screenWidth * 0.05;
            double fontSize = screenWidth * 0.04;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Loop through the categories and create buttons for each
                  ...['Housing', 'Food', 'Transport', 'Entertainment']
                      .map((category) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkBlue,
                                minimumSize:
                                    Size(screenWidth, 50), // Full-width buttons
                              ),
                              onPressed: () {
                                final expenses = Provider.of<ExpenseProvider>(
                                        context,
                                        listen: false)
                                    .getExpensesByCategory(category);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExpenseListScreen(expenses: expenses),
                                  ),
                                );
                              },
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
