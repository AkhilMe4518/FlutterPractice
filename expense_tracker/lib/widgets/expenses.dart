import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpenses = [
    Expense(
        title: "akhil",
        amount: 84293,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerdExpenses.indexOf(expense);
    setState(() {
      _registerdExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerdExpenses.insert(expenseIndex, expense);
              });
            }),
        duration: Duration(seconds: 3),
        content: Text("Expense Deleted")));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              addExpense: _addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No Expense Found..Start Adding Some"),
    );
    if (_registerdExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerdExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Expense Tracker'), actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ]),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registerdExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registerdExpenses)),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
