import 'package:expanse_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expanse_tracker/models/expense.dart';
import 'package:expanse_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cinema",
        amount: 12.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(onAddExpense: _addNewExpense));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          "Expense deleted",
        ),
        action: SnackBarAction(label: "Undo", onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Scaffold(
      body: Center(
        child: Text("No expenses found. Add Some!"),
      ),
    );

    if (_registeredExpenses.isEmpty) {
      return mainContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Text("The charts"),
          Expanded(
              child: ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
          )),
        ],
      ),
    );
  }
}
