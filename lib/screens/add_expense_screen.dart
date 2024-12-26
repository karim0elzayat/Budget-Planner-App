import 'package:budget_planner_app/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner_app/utils/app_colors.dart';
import 'package:budget_planner_app/models/expense.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;

  // Categories for selection
  final List<String> _categories = [
    'Housing',
    'Food',
    'Transport',
    'Entertainment'
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // Show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: AppColors.charcoal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          // Adjust padding and font size based on screen size
          double padding = screenWidth * 0.05;
          double fontSize = screenWidth * 0.05;
          double buttonFontSize = screenWidth * 0.04;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Amount Field
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(fontSize: fontSize),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(fontSize: fontSize),
                    ),
                    value: _selectedCategory,
                    items: _categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Date Picker Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: _selectedDate == null
                          ? 'Select Date'
                          : _selectedDate!.toLocal().toString().split(' ')[0],
                      labelStyle: TextStyle(fontSize: fontSize),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Save Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final expense = Expense(
                          amount: double.parse(_amountController.text),
                          category: _selectedCategory!,
                          date: _selectedDate!.toLocal().toString(),
                        );
                        // Add expense to provider
                        Provider.of<ExpenseProvider>(context, listen: false)
                            .addExpense(expense);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Expense added!')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save Expense',
                      style: TextStyle(
                          fontSize: buttonFontSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
