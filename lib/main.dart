import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_planner_app/screens/home_screen.dart';
import 'package:budget_planner_app/providers/expense_provider.dart';
import 'package:budget_planner_app/utils/app_colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: BudgetPlannerApp(),
    ),
  );
}

class BudgetPlannerApp extends StatelessWidget {
  const BudgetPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Planner',
      theme: ThemeData(
        primaryColor: AppColors.charcoal,
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal),
          bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkBlue),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
