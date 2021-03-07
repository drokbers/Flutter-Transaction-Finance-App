import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/image/broke.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'You didnt add any transactions yet!!',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            '${transactions[index].amount.toStringAsFixed(2)} \₺',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat('dd/MM/yyyy')
                        .format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTransactions(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length, // transaction.map yerine
            ),
    );
  }
}
