import 'package:expense_tracker/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key,required this.onAddExpense});

  final void Function(Expenses expense) onAddExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _numController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _currentDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_numController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text
        .trim()
        .isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) =>
              AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("Please Review the provided Information"),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(ctx);
                  }, child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expenses(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }


  @override
  void dispose() {
    _numController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  var _enteredTitle = '';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }

  var _setCategory = Category.food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,40,15,15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _numController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('Amount')),
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "No Selected Date"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _currentDate,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
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
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("Save Expense"))
            ],
          )
        ],
      ),
    );
  }
}
