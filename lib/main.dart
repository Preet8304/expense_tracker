import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 200, 20, 20));

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme:const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
        color: Colors.blue
      )
    ),
    home: const Expense(),
    debugShowCheckedModeBanner: false,
  ));
}
