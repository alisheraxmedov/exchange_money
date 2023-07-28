import 'package:flutter/material.dart';
import 'package:money_exchange/Screens/exchange_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExchangePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.yellow),
      ),
    ),
  );
}
