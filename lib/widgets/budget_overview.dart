import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:budget_planner_app/providers/expense_provider.dart';
import 'package:budget_planner_app/utils/app_colors.dart';

class BudgetOverview extends StatelessWidget {
  const BudgetOverview({super.key, required bool showCategoryNames});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final totalHousing = expenseProvider.getCategoryTotal('Housing');
    final totalFood = expenseProvider.getCategoryTotal('Food');
    final totalTransport = expenseProvider.getCategoryTotal('Transport');
    final totalEntertainment =
        expenseProvider.getCategoryTotal('Entertainment');

    final totalExpenses = expenseProvider.getTotalExpenses();

    double housingPercentage =
        totalExpenses > 0 ? (totalHousing / totalExpenses) * 100 : 0;
    double foodPercentage =
        totalExpenses > 0 ? (totalFood / totalExpenses) * 100 : 0;
    double transportPercentage =
        totalExpenses > 0 ? (totalTransport / totalExpenses) * 100 : 0;
    double entertainmentPercentage =
        totalExpenses > 0 ? (totalEntertainment / totalExpenses) * 100 : 0;

    final totalCalculated = housingPercentage +
        foodPercentage +
        transportPercentage +
        entertainmentPercentage;
    final adjustment = 100 - totalCalculated;

    if (adjustment > 0) {
      if (housingPercentage == 0) {
        housingPercentage += adjustment;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        return Column(
          children: [
            Text(
              'Budget Overview',
              style: TextStyle(
                  fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: housingPercentage,
                      color: AppColors.charcoal,
                      titleStyle:
                          TextStyle(color: Colors.transparent), // No title
                    ),
                    PieChartSectionData(
                      value: foodPercentage,
                      color: AppColors.darkBlue,
                      titleStyle:
                          TextStyle(color: Colors.transparent), // No title
                    ),
                    PieChartSectionData(
                      value: transportPercentage,
                      color: Colors.green,
                      titleStyle:
                          TextStyle(color: Colors.transparent), // No title
                    ),
                    PieChartSectionData(
                      value: entertainmentPercentage,
                      color: Colors.orange,
                      titleStyle:
                          TextStyle(color: Colors.transparent), // No title
                    ),
                  ],
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: screenWidth * 0.05,
              children: [
                _buildCategoryRow(
                    AppColors.charcoal, 'Housing', housingPercentage),
                _buildCategoryRow(AppColors.darkBlue, 'Food', foodPercentage),
                _buildCategoryRow(
                    Colors.green, 'Transport', transportPercentage),
                _buildCategoryRow(
                    Colors.orange, 'Entertainment', entertainmentPercentage),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryRow(
      Color color, String categoryName, double percentage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          '$categoryName - ${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
