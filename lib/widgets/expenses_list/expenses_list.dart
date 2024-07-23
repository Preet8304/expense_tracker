import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.expenses,required this.onRemoveExpense, super.key});

  final List<Expenses> expenses;
  final void Function(Expenses expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) =>
          Dismissible(
              key: ValueKey(expenses[index]),
              child: ExpenseItem(expenses[index]),
            onDismissed:(direction){
                onRemoveExpense(expenses[index]);
            },),
    );
  }
}
