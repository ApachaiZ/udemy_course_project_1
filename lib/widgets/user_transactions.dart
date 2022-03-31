import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => UserTransactionsState();
}

class UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "Inosuke Sweat-shirt",
      amount: 15.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Nezuko Sweat-shirt",
      amount: 11.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Inosuke Portefeuille",
      amount: 4.99,
      date: DateTime.now(),
    ),
  ];

  void addNewTransaction(String title, double amount) {
    setState(() {
      _userTransactions.add(Transaction(
          id: "t${_userTransactions.length}",
          title: title,
          amount: amount,
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTransaction: addNewTransaction),
        TransactionList(
          transactions: _userTransactions,
        ),
      ],
    );
  }
}
