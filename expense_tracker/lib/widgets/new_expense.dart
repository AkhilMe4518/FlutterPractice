import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredText = '';
  // void _saveTitleInput(String inputText) {
  //   _enteredText = inputText;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final _now = DateTime.now();
    final _firstDate = DateTime(_now.year - 1, _now.month, _now.day);
    final _lastDate = DateTime(_now.year + 1, _now.month, _now.day);

    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: _now,
        firstDate: _firstDate,
        lastDate: _lastDate);
    setState(() {
      _selectedDate = _pickedDate;
    });
  }

  void _addDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: ((ctx) => CupertinoAlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please Make sure a valid Category,Date,title,amount is correct"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay!'))
                ],
              )));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please Make sure a valid Category,Date,title,amount is correct"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay!'))
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        (enteredAmount == null || enteredAmount <= 0) ||
        _selectedDate == null) {
      _addDialog();
      return;
    }
    widget.addExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text("Amount"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'NoDateSelected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month)),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 15),
              Row(children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      _submitExpenseData();
                    },
                    child: const Text("Save Expense")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),

                // ElevatedButton(
              ]),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
