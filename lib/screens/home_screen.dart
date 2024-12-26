import 'package:flutter/material.dart';
import 'package:budget_planner_app/widgets/budget_overview.dart';
import 'package:budget_planner_app/screens/add_expense_screen.dart';
import 'package:budget_planner_app/screens/expense_category_screen.dart'; // Import ExpenseCategoryScreen
import 'package:budget_planner_app/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Planner'),
        backgroundColor: AppColors.charcoal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
            child: Column(
              children: [
                Expanded(
                    child: const BudgetOverview(
                  showCategoryNames: true,
                )), // PieChart and Budget Overview
                const SizedBox(height: 20),
                // Add Expense Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddExpenseScreen()),
                    );
                  },
                  child: Text(
                    'Add Expense',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // View Expenses by Category Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpenseCategoryScreen()),
                    );
                  },
                  child: Text(
                    'View Expenses by Category',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
